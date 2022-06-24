import axios from 'axios';
import { LoginRes } from "@/api/user";

export interface Database {
    host: string,
    port: string,
    name: string,
    user: string,
    password: string
}

export interface Redis {
    host: string,
    port: string,
    password: string
}

export function saveDatabase(data: Database) {
    return axios.post<T>('/admin/database/save', data);
}

export function saveRedis(data: Redis) {
    return axios.post<T>('/admin/redis/save', data);
}