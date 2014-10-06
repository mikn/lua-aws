--[[
AWSAccessKeyId=$AWS_ACCESS_KEY&
Action=SendMessage&
MessageBody=testing&
QueueUrl=http%3A%2F%2Fsqs.ap-northeast-1.amazonaws.com%2F871570535967%2FtestQueue&
Signature=hchgVw%2B5D5vwSSCgMVsOt5ycJjb6bDOpNmCe4EpLavo%3D&
SignatureMethod=HmacSHA256&
SignatureVersion=2&
Timestamp=2014-10-06T03%3A46%3A55.305Z&
Version=2012-11-05
]]--

local v2signer = require 'lua-aws.signers.v2'
local endpoint = require 'lua-aws.requests.endpoint'
local util = require 'lua-aws.util'

local signer = v2signer.new()

local params = {
	Action = "SendMessage",
	QueueUrl = "http://sqs.ap-northeast-1.amazonaws.com/871570535967/testQueue",
	MessageBody = "testing",
	Version = "2012-11-05"
}

signer:sign({
	method = "POST",
	headers = {},
	host = "sqs.ap-northeast-1.amazonaws.com",
	path = "/",
	params = params,
}, {
	accessKeyId = os.getenv('AWS_ACCESS_KEY'),
	secretAccessKey = os.getenv('AWS_SECRET_KEY'),
}, "2014-10-06T03:46:55.305Z")

-- TODO : can we provide universal test??? now its only for *ME*
print('params:', params.Signature, util.unescape("hchgVw%2B5D5vwSSCgMVsOt5ycJjb6bDOpNmCe4EpLavo%3D"))
assert(params.Signature == util.unescape("hchgVw%2B5D5vwSSCgMVsOt5ycJjb6bDOpNmCe4EpLavo%3D"))
