<template>
    <div class="container">
        <Breadcrumb :items="['menu.system', 'menu.system.user']" />
        <a-card class="general-card" :title="$t('menu.system.user')">
            <a-row>
                <a-col :flex="1">
                    <a-form :model="formModel" :label-col-props="{ span: 6 }" :wrapper-col-props="{ span: 18 }"
                        label-align="left">
                        <a-row :gutter="16">
                            <a-col :span="8">
                                <a-form-item field="number" :label="$t('searchTable.form.number')">
                                    <a-input v-model="formModel.number"
                                        :placeholder="$t('searchTable.form.number.placeholder')" />
                                </a-form-item>
                            </a-col>
                            <a-col :span="8">
                                <a-form-item field="name" :label="$t('searchTable.form.name')">
                                    <a-input v-model="formModel.name"
                                        :placeholder="$t('searchTable.form.name.placeholder')" />
                                </a-form-item>
                            </a-col>
                            <a-col :span="8">
                                <a-form-item field="contentType" :label="$t('searchTable.form.contentType')">
                                    <a-select v-model="formModel.contentType" :options="contentTypeOptions"
                                        :placeholder="$t('searchTable.form.selectDefault')" />
                                </a-form-item>
                            </a-col>
                            <a-col :span="8">
                                <a-form-item field="filterType" :label="$t('searchTable.form.filterType')">
                                    <a-select v-model="formModel.filterType" :options="filterTypeOptions"
                                        :placeholder="$t('searchTable.form.selectDefault')" />
                                </a-form-item>
                            </a-col>
                            <a-col :span="8">
                                <a-form-item field="createdTime" :label="$t('searchTable.form.createdTime')">
                                    <a-range-picker v-model="formModel.createdTime" style="width: 100%" />
                                </a-form-item>
                            </a-col>
                            <a-col :span="8">
                                <a-form-item field="status" :label="$t('searchTable.form.status')">
                                    <a-select v-model="formModel.status" :options="statusOptions"
                                        :placeholder="$t('searchTable.form.selectDefault')" />
                                </a-form-item>
                            </a-col>
                        </a-row>
                    </a-form>
                </a-col>
                <a-divider style="height: 84px" direction="vertical" />
                <a-col :flex="'86px'" style="text-align: right">
                    <a-space direction="vertical" :size="18">
                        <a-button type="primary" @click="search">
                            <template #icon>
                                <icon-search />
                            </template>
                            {{ $t('searchTable.form.search') }}
                        </a-button>
                        <a-button @click="reset">
                            <template #icon>
                                <icon-refresh />
                            </template>
                            {{ $t('searchTable.form.reset') }}
                        </a-button>
                    </a-space>
                </a-col>
            </a-row>
            <a-divider style="margin-top: 0" />
            <a-row style="margin-bottom: 16px">
                <a-col :span="16">
                    <a-space>
                        <a-button type="primary" v-permission="['add-user']">
                            <template #icon>
                                <icon-plus />
                            </template>
                            {{ $t('row.operation.create') }}
                        </a-button>
                        <a-upload action="/">
                            <template #upload-button>
                                <a-button v-permission="['import-user']">
                                    {{ $t('row.operation.import') }}
                                </a-button>
                            </template>
                        </a-upload>
                    </a-space>
                </a-col>
                <a-col :span="8" style="text-align: right">
                    <a-button v-permission="['export-user']">
                        <template #icon>
                            <icon-download />
                        </template>
                        {{ $t('searchTable.operation.download') }}
                    </a-button>
                </a-col>
            </a-row>
            <a-table row-key="id" :loading="loading" :pagination="pagination" :data="renderData" :bordered="false"
                @page-change="onPageChange">
                <template #columns>
                    <a-table-column :title="$t('systemUser.list.ID')" data-index="adminId" />
                    <a-table-column :title="$t('systemUser.list.username')" data-index="username" />
                    <a-table-column :title="$t('systemUser.list.name')" data-index="name" />
                    <a-table-column :title="$t('systemUser.list.createTime')" data-index="createTime" />
                    <a-table-column :title="$t('systemUser.list.status')" data-index="status">
                        <template #cell="{ record }">
                            <span v-if="record.status === 1" class="circle"></span>
                            <span v-else class="circle pass"></span>
                            {{ record.status === 1 ? $t(`systemUser.form.status.enable`) :
                            $t(`systemUser.form.status.disabled`) }}
                        </template>
                    </a-table-column>
                    <a-table-column :title="$t('row.operations')" data-index="operations">
                        <template #cell=" {record }">
                            <a-button v-permission="['user-edit']" type="text" size="small">
                                {{ $t('row.operation.edit') }}
                            </a-button>
                            <a-button v-permission="['user-delete']" type="text" size="small">
                                {{ record.status !== 1 ? $t(`systemUser.form.status.enable`) :
                                $t(`systemUser.form.status.disabled`) }}
                            </a-button>
                        </template>
                    </a-table-column>
                </template>
            </a-table>
        </a-card>
    </div>
</template>

<script lang="ts" setup>
import { computed, ref, reactive } from 'vue';
import { useI18n } from 'vue-i18n';
import useLoading from '@/hooks/loading';
import { queryPolicyList, PolicyRecord, PolicyParams } from '@/api/adminUser';
import { Pagination } from '@/types/global';
import type { SelectOptionData } from '@arco-design/web-vue/es/select/interface';

const generateFormModel = () => {
    return {
        number: '',
        name: '',
        contentType: '',
        filterType: '',
        createdTime: [],
        status: '',
    };
};
const { loading, setLoading } = useLoading(true);
const { t } = useI18n();
const renderData = ref<PolicyRecord[]>([]);
const formModel = ref(generateFormModel());
const basePagination: Pagination = {
    current: 1,
    pageSize: 20,
};
const pagination = reactive({
    ...basePagination,
});
const contentTypeOptions = computed<SelectOptionData[]>(() => [
    {
        label: t('searchTable.form.contentType.img'),
        value: 'img',
    },
    {
        label: t('searchTable.form.contentType.horizontalVideo'),
        value: 'horizontalVideo',
    },
    {
        label: t('searchTable.form.contentType.verticalVideo'),
        value: 'verticalVideo',
    },
]);
const filterTypeOptions = computed<SelectOptionData[]>(() => [
    {
        label: t('searchTable.form.filterType.artificial'),
        value: 'artificial',
    },
    {
        label: t('searchTable.form.filterType.rules'),
        value: 'rules',
    },
]);
const statusOptions = computed<SelectOptionData[]>(() => [
    {
        label: t('searchTable.form.status.online'),
        value: 'online',
    },
    {
        label: t('searchTable.form.status.offline'),
        value: 'offline',
    },
]);
const fetchData = async (
    params: PolicyParams = { current: 1, pageSize: 20 }
) => {
    setLoading(true);
    try {
        const { data } = await queryPolicyList(params);
        renderData.value = data.list;
        pagination.current = params.current;
        pagination.total = data.total;
    } catch (err) {
        // you can report use errorHandler or other
    } finally {
        setLoading(false);
    }
};

const search = () => {
    fetchData({
        ...basePagination,
        ...formModel.value,
    } as unknown as PolicyParams);
};
const onPageChange = (current: number) => {
    fetchData({ ...basePagination, current });
};

fetchData();
const reset = () => {
    formModel.value = generateFormModel();
};
</script>

<script lang="ts">
export default {
    name: 'SearchTable',
};
</script>

<style scoped lang="less">
.container {
    padding: 0 20px 20px 20px;
}

:deep(.arco-table-th) {
    &:last-child {
        .arco-table-th-item-title {
            margin-left: 16px;
        }
    }
}
</style>
