import localeMessageBox from '@/components/message-box/locale/en-US';
import localeLogin from '@/views/login/locale/en-US';

import localeWorkplace from '@/views/dashboard/workplace/locale/en-US';
import localeInstall from '@/views/install/locale/en-US';
import localeSystemUser from '@/views/system/user/locale/en-US';

import localeSettings from './en-US/settings';

export default {
  'menu.dashboard': 'Dashboard',
  'menu.install': 'System Install',
  'menu.server.dashboard': 'Dashboard-Server',
  'menu.server.workplace': 'Workplace-Server',
  'menu.server.monitor': 'Monitor-Server',
  'menu.list': 'List',
  'menu.result': 'Result',
  'menu.exception': 'Exception',
  'menu.form': 'Form',
  'menu.profile': 'Profile',
  'menu.visualization': 'Data Visualization',
  'menu.user': 'User Center',
  'menu.arcoWebsite': 'Arco Design',
  'menu.faq': 'FAQ',
  'navbar.docs': 'Docs',
  'navbar.action.locale': 'Switch to English',
  'menu.system': 'System Setting',
  'row.operations': 'Operation',
  'row.operation.view': 'View',
  'row.operation.edit': 'Edit',
  'row.operation.delete': 'Delete',
  'row.operation.create': 'Create',
  'row.operation.import': 'Import',
  'list.search': 'Search',
  'list.reset': 'Reset',
  ...localeSettings,
  ...localeMessageBox,
  ...localeLogin,
  ...localeWorkplace,
  ...localeInstall,
  ...localeSystemUser
};
