<?php


namespace App\service;


use app\constant\ApiError;
use App\constant\VerifyStep;
use app\exception\ApiException;
use app\model\User;
use app\model\UserVerifyContact;

class VerifyService
{
    /**
     * 信息认证-第一步
     * @param $userId
     * @param $personal
     * @return bool
     * @throws ApiException
     */
    public static function verifyStepOne($userId, $personal) {
        /** @var User $user */
        $user = User::query()->find($userId);
        if (!$user) {
            throw new ApiException(ApiError::UserNotExisit);
        }

        try {
            \support\Db::beginTransaction();
            $user->verify->update([
                'first_name' => $personal['firstName'],
                'middle_name' => $personal['middleName'],
                'last_name' => $personal['lastName'],
                'gender' => $personal['gender'],
                'birth_date' => $personal['birth'],
                'martial_status' => $personal['maritalStatus'],
                'number_of_children' => $personal['numberOfChildren'],
            ]);

            $user->current_verify_step = VerifyStep::STEP_ONE;
            $user->first_name = $personal['firstName'];
            $user->middle_name = $personal['middleName'];
            $user->last_name = $personal['lastName'];
            $user->gender = $personal['gender'];
            $user->birth_day = $personal['birth'];
            $user->real_full_name = sprintf('%s %s %s', $personal['firstName'], $personal['middleName'], $personal['lastName']);
            $user->save();
            \support\Db::commit();
        } catch (\Throwable $e) {
            \support\Db::rollBack();
            throw $e;
        }

        return true;
    }

    /**
     * 信息认证-第二步
     * @param $userId
     * @param $contacts
     * @return bool
     * @throws ApiException
     * @throws \Throwable
     */
    public static function verifyStepTwo($userId, $contacts) {

        /** @var User $user */
        $user = User::query()->find($userId);
        if (!$user) {
            throw new ApiException(ApiError::UserNotExisit);
        }

        try {
            \support\Db::beginTransaction();

            $familyContactArr = json_decode($contacts['familyRelation'], true);
            $otherContactArr = json_decode($contacts['otherRelation'], true);

            $familyContact = new UserVerifyContact();
            $familyContact->user_verify_id = $user->verify->user_verify_id;
            $familyContact->phone = $familyContactArr['phone'];
            $familyContact->name = $familyContactArr['name'];
            $familyContact->relation = 'family';
            $familyContact->save();

            $otherContact = new UserVerifyContact();
            $otherContact->user_verify_id = $user->verify->user_verify_id;
            $otherContact->phone = $otherContactArr['phone'];
            $otherContact->name = $otherContactArr['name'];
            $otherContact->relation = 'other';
            $otherContact->save();

            $user->verify->state = $contacts['state'];
            $user->verify->city = $contacts['city'];
            $user->verify->address = $contacts['address'];
            $user->verify->family_contact_id = $familyContact->user_verify_contact_id;
            $user->verify->other_contact_id = $otherContact->user_verify_contact_id;
            $user->verify->save();

            $user->current_verify_step = VerifyStep::STEP_TWO;
            $user->save();

            \support\Db::commit();
        } catch (\Throwable $t) {
            \support\Db::rollBack();
            throw $t;
        }


        return true;
    }


    /**
     * 信息认证-第三步
     * @param $userId
     * @param $workInfo
     * @return bool
     * @throws ApiException
     * @throws \Throwable
     */
    public static function verifyStepThree($userId, $workInfo) {
        /** @var User $user */
        $user = User::query()->find($userId);
        if (!$user) {
            throw new ApiException(ApiError::UserNotExisit);
        }

        try {
            \support\Db::beginTransaction();
            $user->verify->educ_id = $workInfo['educLevel'];
            $user->verify->employment_status_id = $workInfo['employmentStatus'];
            $user->verify->employer_name = $workInfo['employerName'];
            $user->verify->employer_period = $workInfo['employerPeriod'];
            $user->verify->salary = $workInfo['salary'];
            $user->verify->salary = $workInfo['salary'];
            $user->verify->pay_day = $workInfo['payDay'];
            $user->verify->save();

            $user->current_verify_step = VerifyStep::STEP_THREE;
            $user->save();

            \support\Db::commit();
        } catch (\Throwable $t) {
            \support\Db::rollBack();
            throw $t;
        }

        return true;
    }

    public static function verifyStepFour($userId, $bankInfo) {
        /** @var User $user */
        $user = User::query()->find($userId);
        if (!$user) {
            throw new ApiException(ApiError::UserNotExisit);
        }

        try {
            \support\Db::beginTransaction();
            $user->verify->id_number = $bankInfo['bvn'];
            $user->verify->bank_code = $bankInfo['bank_code'];
            //$user->verify->bank_name = $workInfo['employerName'];
            $user->verify->bank_number = $bankInfo['bankNumber'];
            $user->verify->save();

            $user->current_verify_step = VerifyStep::STEP_FOUR;
            $user->save();

            \support\Db::commit();
        } catch (\Throwable $t) {
            \support\Db::rollBack();
            throw $t;
        }

        return true;
    }
}