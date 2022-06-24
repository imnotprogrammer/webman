import Mock from 'mockjs';
import qs from 'query-string';
import setupMock, { successResponseWrap } from '@/utils/setup-mock';
import { GetParams } from '@/types/global';

const { Random } = Mock;

const data = Mock.mock({
    'list|55': [
        {
            'adminId|4': /[0-9]/,
            'username|4-8': /[A-Z]/,
            'name|4-8': /[A-Z]/,
            'status|1': [1, 0],
            'createTime': Random.datetime(),
        },
    ],
});

setupMock({
    setup() {
        Mock.mock(new RegExp('/api/list/policy'), (params: GetParams) => {
            const { current = 1, pageSize = 10 } = qs.parseUrl(params.url).query;
            const p = current as number;
            const ps = pageSize as number;
            return successResponseWrap({
                list: data.list.slice((p - 1) * ps, p * ps),
                total: 55,
            });
        });
    },
});
