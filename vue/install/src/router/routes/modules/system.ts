import { DEFAULT_LAYOUT } from '@/router/constans';

export default {
    path: '/system',
    name: 'system',
    component: DEFAULT_LAYOUT,
    meta: {
        locale: 'menu.system',
        requiresAuth: true,
        icon: 'icon-dashboard',
        order: 0,
    },
    children: [
        {
            path: 'user',
            name: 'user',
            component: () => import('@/views/system/user/index.vue'),
            meta: {
                locale: 'menu.system.user',
                requiresAuth: true,
                roles: ['*'],
            },
        },
    ],
};
