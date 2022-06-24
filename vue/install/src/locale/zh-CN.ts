import localeMessageBox from '@/components/message-box/locale/zh-CN';
import localeLogin from '@/views/login/locale/zh-CN';

import localeWorkplace from '@/views/dashboard/workplace/locale/zh-CN';

import localeInstall from '@/views/install/locale/zh-CN';
import localeSystemUser from '@/views/system/user/locale/zh-CN';

import localeSettings from './zh-CN/settings';

export default {
  'menu.dashboard': '仪表盘',
  'menu.system': '系统设置',
  'menu.system.user': '用户管理',
  'menu.system.role': '角色管理',
  'menu.system.permission': '权限管理',
  'menu.system.menu': '菜单管理',
  'menu.server.dashboard': '仪表盘-服务端',
  'menu.server.workplace': '工作台-服务端',
  'menu.install': '系统安装',
  'menu.server.monitor': '实时监控-服务端',
  'menu.list': '列表页',
  'menu.result': '结果页',
  'menu.exception': '异常页',
  'menu.form': '表单页',
  'menu.profile': '详情页',
  'menu.visualization': '数据可视化',
  'menu.user': '个人中心',
  'menu.arcoWebsite': 'Arco Design',
  'menu.faq': '常见问题',
  'navbar.docs': '文档中心',
  'navbar.action.locale': '切换为中文',
  'row.operations': '操作',
  'row.operation.view': '查看',
  'row.operation.edit': '编辑',
  'row.operation.delete': '删除',
  'row.operation.create': '新建',
  'row.operation.import': '导入',
  'list.search': '查询',
  'list.reset': '重置',
  ...localeSettings,
  ...localeMessageBox,
  ...localeLogin,
  ...localeWorkplace,
  ...localeInstall,
  ...localeSystemUser
};
