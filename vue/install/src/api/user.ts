import axios from 'axios';
import type { RouteRecordNormalized } from 'vue-router';
import { UserState } from '@/store/modules/user/types';

export interface LoginData {
  username: string;
  password: string;
}

export interface Menus {
  menu: RouteRecordNormalized[],
  permissions: Array<T>
}

export interface LoginRes {
  token: string;
}
export function login(data: LoginData) {
  return axios.post<LoginRes>('/admin/login', data);
}

export function logout() {
  return axios.post<LoginRes>('/api/user/logout');
}

export function getUserInfo() {
  return axios.get<UserState>('/admin/info');
}

export function getMenuList() {
  return axios.get<RouteRecordNormalized[]>('/admin/menus');
}
