--
-- TencentBlueKing is pleased to support the open source community by making
-- 蓝鲸智云 - API 网关(BlueKing - APIGateway) available.
-- Copyright (C) 2017 THL A29 Limited, a Tencent company. All rights reserved.
-- Licensed under the MIT License (the "License"); you may not use this file except
-- in compliance with the License. You may obtain a copy of the License at
--
--     http://opensource.org/licenses/MIT
--
-- Unless required by applicable law or agreed to in writing, software distributed under
-- the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
-- either express or implied. See the License for the specific language governing permissions and
-- limitations under the License.
--
-- We undertake not to change the open source license (MIT license) applicable
-- to the current version of the project delivered to anyone in the future.
--

-- # bk-mock
--
-- support mock the response for an route, you can mock the status, body and headers of the response.
-- note: the plugin not re-use the official plugin mocking
-- because:
-- 1. the official plugin does not support response_headers
-- 2. the official plugin do `core.utils.resolve_var(response_content, ctx.var)` in access phase,
--    may cause sensitive information leakage

local core = require("apisix.core")

local plugin_name = "demo"

local schema = {
    type = "object",
    properties = {
        -- specify response status,default 200
        response_status = {
            type = "integer",
            default = 200,
            minimum = 100,
        },
    },
}

local _M = {
    version = 0.1,
    priority = 17150,
    name = plugin_name,
    schema = schema,
}

function _M.check_schema(conf)
    return core.schema.check(schema, conf)
end

function _M.access(conf, ctx)
    core.log.warn(core.json.encode(ctx, true))
    return conf.response_status
end

return _M
