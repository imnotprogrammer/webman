<template>
  <div class="frame-bg">
    <div class="frame-body">
      <div class="frame-aside">
        <a-page-header title="安装步骤" :show-back="false">
          <a-steps direction="vertical" :current="current" @change="setCurrent" style="width:100%; border-right: 1px solid var(--color-border);">
            <a-step description="填写应用的基础信息">基本信息</a-step>
            <a-step description="为应用的数据库进行配置">数据库配置</a-step>
            <a-step description="填写缓存配置">Redis配置</a-step>
            <a-step description="信息填写完成后,开始初始化应用信息">初始化</a-step>
          </a-steps>
        </a-page-header>
      </div>
      <div class="frame-main">
        <div class="main-content" style="overflow-y: scroll;"  v-if="current == 1">
          <a-page-header title="用户协议" :show-back="false" @back="handleBack">
            <a-typography style="text-align: left; ">
              <a-typography-title :heading="5">Default</a-typography-title>
              <a-typography-paragraph>
                A design is a plan or specification for the construction of an object or system or for the implementation of an activity or process, or the result of that plan or specification in the form of a prototype, product or process. The verb to design expresses the process of developing a design. In some cases, the direct construction of an object without an explicit prior plan (such as in craftwork, some engineering, coding, and graphic design) may also be considered to be a design activity.
              </a-typography-paragraph>
              <a-typography-title :heading="5">Secondary</a-typography-title>
              <a-typography-paragraph type="secondary">
                A design is a plan or specification for the construction of an object or system or for the implementation of an activity or process, or the result of that plan or specification in the form of a prototype, product or process. The verb to design expresses the process of developing a design. In some cases, the direct construction of an object without an explicit prior plan (such as in craftwork, some engineering, coding, and graphic design) may also be considered to be a design activity.
              </a-typography-paragraph>
              <a-typography-title :heading="5">Spacing default</a-typography-title>
              <a-typography-paragraph>
                A design is a plan or specification for the construction of an object or system or for the implementation of an activity or process, or the result of that plan or specification in the form of a prototype, product or process. The verb to design expresses the process of developing a design. In some cases, the direct construction of an object without an explicit prior plan (such as in craftwork, some engineering, coding, and graphic design) may also be considered to be a design activity.
              </a-typography-paragraph>
              <a-typography-title :heading="5">Spacing close</a-typography-title>
              <a-typography-paragraph type="secondary" spacing="close">
                A design is a plan or specification for the construction of an object or system or for the implementation of an activity or process, or the result of that plan or specification in the form of a prototype, product or process. The verb to design expresses the process of developing a design.
              </a-typography-paragraph>
            </a-typography>
            <a-checkbox v-model="isAgree" style="height:40px;line-height: 40px;">
              我已阅读并同意此协议
            </a-checkbox>
          </a-page-header>
        </div>
        <div class="main-content" v-if="current == 2">
          <a-page-header title="数据库配置" @back="handleBack">
            <a-form :model="db" layout="vertical" style="width:400px;" @submit="handleSubmit">
              <a-form-item :rules="rules.dbHost" field="host" label="数据库服务器">
                <a-input  v-model="db.host" placeholder="填写数据库地址,eg:localhost" />
              </a-form-item>
              <a-form-item :rules="rules.dbPort" field="port" label="数据库服务端口">
                <a-input  v-model="db.port" placeholder="填写数据库服务端口,eg:3306" />
              </a-form-item>
              <a-form-item :rules="rules.dbUser" field="user" label="数据库用户名">
                <a-input  v-model="db.user" placeholder="填写数据库服务用户名,eg:root" />
              </a-form-item>
              <a-form-item :rules="rules.dbPassword" field="password" label="数据库密码">
                <a-input-password  v-model="db.password"  placeholder="填写数据库服务密码" />
              </a-form-item>
              <a-form-item :rules="rules.dbName" field="name" label="数据库名">
                <a-input v-model="db.name" placeholder="填写数据库名称" />
              </a-form-item>
              <a-form-item>
                <a-button type='primary' html-type="submit" :loading="databaseLoading">保存</a-button>
              </a-form-item>
            </a-form>
          </a-page-header>

        </div>
        <div class="main-content" v-if="current == 3">
          <a-page-header title="Redis配置" @back="handleBack">
            <a-form :model="redis" layout="vertical" style="width:400px;" @submit="handleSubmitRedis">
              <a-form-item :rules="rules.redisHost" field="host" label="Redis地址">
                <a-input  v-model="redis.host" placeholder="填写Redis地址,eg:localhost" />
              </a-form-item>
              <a-form-item :rules="rules.redisPort" field="port" label="Redis端口号">
                <a-input  v-model="redis.port" placeholder="填写Redis服务端口,eg:6379" />
              </a-form-item>
              <a-form-item :rules="rules.redisAuth" field="auth" label="Redis认证密码">
                <a-input  v-model="redis.auth" placeholder="填写Redis认证密码" />
              </a-form-item>

              <a-form-item>
                <a-button type='primary' html-type="submit" :loading="redisLoading">保 存</a-button>
              </a-form-item>
            </a-form>
          </a-page-header>

        </div>
        <div class="main-content" v-if="current == 4">
          <a-page-header title="管理员配置" @back="handleBack">
            <a-form :model="base" layout="vertical" style="width:400px;" @submit="handleSubmitBase">
              <a-form-item :rules="rules.appName" field="appName" label="应用名称">
                <a-input  v-model="base.appName" placeholder="填写应用名称" />
              </a-form-item>
              <a-form-item :rules="rules.locale" field="locale" label="应用语言">
                <a-select defaultValue="Beijing" :style="{width:'320px'}" placeholder="请选择应用语言" disabled>
                  <a-option>Beijing</a-option>
                  <a-option>Shanghai</a-option>
                  <a-option>Guangzhou</a-option>
                  <a-option disabled>Disabled</a-option>
                </a-select>
              </a-form-item>
              <a-form-item :rules="rules.timezone" field="timezone" label="时区选择">
                <a-input  v-model="base.timezone" placeholder="选择时区" />
              </a-form-item>
              <a-form-item :rules="rules.adminName" field="username" label="管理后台用户名">
                <a-input  v-model="base.username" placeholder="填写登录用户名" />
              </a-form-item>
              <a-form-item :rules="rules.adminPassword" field="password" label="管理后台用户密码">
                <a-input  v-model="base.password" placeholder="管理员密码" />
              </a-form-item>
              <a-form-item :rules="rules.adminConfirmPassword" field="confirmPassword" label="管理后台用户确认密码">
                <a-input  v-model="base.confirmPassword" placeholder="确认管理员密码" />
              </a-form-item>

              <a-form-item>
                <a-button type='primary' html-type="submit" :loading="initLoading">保存并执行初始化</a-button>
              </a-form-item>
            </a-form>
          </a-page-header>

        </div>
        <div class="main-bottom">
          <a-button :disabled="current==1" @click="onPrev">
            <icon-left />
            Back
          </a-button>
          <a-button :disabled="current==4 || !isAgree" @click="onNext">
            Next
            <icon-right />
          </a-button>
        </div>
      </div>
    </div>
  </div>

</template>


<script>
import {reactive,ref} from "vue";
import {saveDatabase, saveRedis} from "@/api/install";
import useLoading from '@/hooks/loading';
import { Message } from '@arco-design/web-vue';

export default {
  data() {
    return {
      current: 1,
    };
  },
  methods: {
    onPrev() {
      this.current = Math.max(1, this.current - 1)
    },

    onNext() {
      this.current = Math.min(4, this.current + 1)
      console.log(this.current);
    },

    setCurrent(current) {
      this.current = current
    },
    handleBack() {
      this.current -= 1;
    }
  },
  mounted() {
     this.setCurrent(this.$route.query.step === undefined ? 1 : this.$route.query.step)
     console.log(this.current)
  },
  setup() {
    const initLoading = ref(false);
    const databaseLoading = ref(false);
    const redisLoading = ref(false);

    const handleSubmit = async ({values, errors}) => {
      try {
        databaseLoading.value = true;
        const res = await saveDatabase({
          host: values.host,
          port: values.port,
          name: values.name,
          user: values.user,
          password: values.password
        });
        if (res.code === 0) {
          Message.info('保存成功');
          return
        }
      } catch (err) {
           // you can report use errorHandler or other
      } finally {
        databaseLoading.value = false;
      }
    }

    const handleSubmitRedis = async ({values, errors}) => {
      try {
        redisLoading.value = true;
        const res = await saveRedis({
          host: values.host,
          port: values.port,
          password: values.password
        });
        if (res.code === 0) {
          Message.info('保存成功');
          return
        }
      } catch (err) {
        // you can report use errorHandler or other
      } finally {
        redisLoading.value = false;
      }
    }

    const handleSubmitBase = ({values, errors}) => {
      initLoading.value = !initLoading.value;
      console.log('values:', values, '\nerrors:', errors)
    }

    const form = reactive({
      size: 'medium',
      name: '',
      age: undefined,
      section: '',
      province: 'haidian',
      options: [],
      date: '',
      radio: 'radio one',
      slider: 5,
      score: 5,
      switch: false,
      multiSelect: ['section one'],
      treeSelect: ''
    });
    const rules = reactive({
      dbName: [
        {
          required: true,
          message: '请填写数据库名称'
        },
        {
          maxLength: 100,
          message: '数据库名称不要超过100个字符'
        }
      ],
      dbHost: [
        {
          required: true,
          message: '请填写数据库地址'
        },
        {
          maxLength: 100,
          message: '数据库地址不要超过100个字符'
        }
      ],
      dbPort: [
        {
          required: true,
          message: '请填写数据库端口'
        },
        {
          maxLength: 100,
          message: '数据库端口不要超过100字符'
        }
      ],
      dbPassword: [
        {
          required: true,
          message: '请填写数据库密码'
        },
        {
          maxLength: 100,
          message: '数据库密码不要超过100字符'
        },
        {
          minLength: 8,
          message: '数据库密码长度最短为8个字符'
        }
      ],
      dbUser: [
        {
          required: true,
          message: '请填写数据库用户'
        },
        {
          maxLength: 100,
          message: '数据库用户不要超过100字符'
        }
      ],

      redisHost: [
        {
          required: true,
          message: '请填写Redis数据库地址'
        },
        {
          maxLength: 100,
          message: 'Redis地址不要超过100字符'
        }
      ],

      redisPort: [
        {
          required: true,
          message: '请填写Redis端口号'
        },
        {
          maxLength: 100,
          message: 'Redis端口不要超过100字符'
        }
      ],

      redisAuth: [
        {
          maxLength: 100,
          message: '数据库用户不要超过100字符'
        }
      ],
      adminName: [
        {
          maxLength: 100,
          message: '数据库用户不要超过100字符'
        }
      ],
      adminPassword: [
        {
          maxLength: 100,
          message: '数据库用户不要超过100字符'
        }
      ],
      adminConfirmPassword: [
        {
          maxLength: 100,
          message: '数据库用户不要超过100字符'
        }
      ],

      timezone: [
        {
          maxLength: 100,
          message: '数据库用户不要超过100字符'
        }
      ],
      appName: [
        {
          maxLength: 100,
          message: '数据库用户不要超过100字符'
        }
      ],
      locale: [
        {
          maxLength: 100,
          message: '数据库用户不要超过100字符'
        }
      ],
    })
    const db = reactive({
      host: 'localhost',
      port: '3306',
      user: 'root',
      password: '',
      name: ''
    });

    const redis = reactive({
      host: 'localhost',
      port: '6379',
      auth: '',
    });

    const base = reactive({
      appName: 'localhost',
      timezone: 'Asia/ShangHai',
      locale: 'zh_CN',
      username: 'admin',
      password: '',
      confirmPassword: '',
    });

    const isAgree = ref(false);

    return {
      form,
      isAgree,
      base,
      db,
      rules,
      redis,
      initLoading,
      databaseLoading,
      redisLoading,
      handleSubmit,
      handleSubmitRedis,
      handleSubmitBase,
    }
  },
};
</script>


<style scoped lang="less">
.frame-bg {
  margin: 2px auto;
  max-width: 60%;
  padding: 40px;
  background: var(--color-fill-2);
}

.frame-body {
  display: flex;
  background: var(--color-bg-2);
}

.frame-aside {
  /*padding: 20px;*/
  /*height: 400px;*/
  width: 40%;

}

.frame-main {
  width: 100%;
}

.main-content {
  /*text-align: center;*/
  line-height: 200px;
  max-height: 600px;

}

.main-bottom {
  display: flex;
  justify-content: center;

  button {
    margin: 50px 20px 20px 20px;
  }
}
</style>