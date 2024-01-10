Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B73EA80
	for <util-linux@vger.kernel.org>; Wed, 10 Jan 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b="W7JdYyNo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fab1hKj6NF25EjASkQBdRzjwfBbAQvqUja4ODFBf3BtsBjiDPCoJOyv8g2aZQslr4lOkkuJTzDCfjlrYDtlo33uiVkQ9uf4LwOAWtI906UPwbbcPEE8dQMnpw5ZoX5rocAitPWhRky6ldQZVRVfhwLyNkyMMcSTpXgwhZx+jFfmBoCRLMw5cdimfTtKxe4lIP6HyKDzbi0kLNTqp49b53v/5v4HtjJg92atAqVKwco4ECKZlB9vPAO+cweF+m5nhpbLJl8DzZ/TTTzwVJBesyUHkcFFZX6htap/pUjPIxn36WdmM54boPK3KHyOTvSugG7sR/SfvDjRnA6DNaMNLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47a2YdSEn7AENZPGusILsJFwn8B/j0/Tj7fdgL1itr0=;
 b=UUl8s9cZT6IDc8pnuNVn8InT5icGfQxgH414zuL4IBTUH3ktlh/zxOIbijE08Tt7SBeBIL7HWeuZOSUapbTEtoAPbHMP9s6YBkaa5KqNTfPbV8AA/2wy9hYq+8u3dLsttxzf7aJfXJRqbAc3eWIj8LO7t47Z2UkDiYpVnvviUaCnH24y0ycCDPFupWF2LC7rBO8jSNMKbG32ONSLAHKw0/xc8MUVU2h3roI8XIC7XQhsCdGpZcjXNXkY5rcQ1hGE4aeNX2Ex1H/Evz1+fuXisxMNf7JardWm4VPraUJK4DAvDSQ4JW53c1+2ZOjWY4q1YJr+75GTn7PsjEahuTdaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47a2YdSEn7AENZPGusILsJFwn8B/j0/Tj7fdgL1itr0=;
 b=W7JdYyNoJxQL4ex4Y56JYNhp7hmJ8BKd62zBJ1ybe3t8ABc94IQqzfMxpfGtoBSeal40PkoTZfEWlFi8YqAOMOJOE8qwbwmACch/yYmvkBm8TSs2VueVHIJarODe3TvplNLI1HftFdXx1JLgwBM149SwkLUrV54DkgUWpGbw4ElgVj41LADQodeCmkXAxk5NLB4NfsjPjw0Eg/bfl3dbzEZAhfWW3ImCnes2JFMS8vMtDd7CpOlxVkzpVq0yM+uMI+v/uKQczovBR5kJE/ZaUVziRGDKhAjbPbsGnPGqyj3gKs8ljCkVNKLieegNG2GFUd7YHc95W6HoGJ38ge03FA==
Received: from AS4PR02MB8550.eurprd02.prod.outlook.com (2603:10a6:20b:585::11)
 by AS8PR02MB7272.eurprd02.prod.outlook.com (2603:10a6:20b:3fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 15:42:33 +0000
Received: from AS4PR02MB8550.eurprd02.prod.outlook.com
 ([fe80::bce7:115b:becf:ca6c]) by AS4PR02MB8550.eurprd02.prod.outlook.com
 ([fe80::bce7:115b:becf:ca6c%3]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 15:42:33 +0000
From: "Trapp, Michael" <michael.trapp@sap.com>
To: Karel Zak <kzak@redhat.com>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] uuidd: add cont_clock persistence
Thread-Topic: [PATCH] uuidd: add cont_clock persistence
Thread-Index: AQHaL6S/76kjiE5l10qY9P0zllFxt7DJr0oAgAmooAA=
Date: Wed, 10 Jan 2024 15:42:33 +0000
Message-ID: <6EFE3540-1C52-48E7-8E18-6C199DB6823F@sap.com>
References: <20231215221829.46932-1-michael.trapp@sap.com>
 <20240104121230.3bi7nt52tb3fu6ww@ws.net.home>
In-Reply-To: <20240104121230.3bi7nt52tb3fu6ww@ws.net.home>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.300.61.1.2)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR02MB8550:EE_|AS8PR02MB7272:EE_
x-ms-office365-filtering-correlation-id: 9a709570-5be8-4497-74b6-08dc11f2c339
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AtDlgLSCnNpqtOcxBnu6FeqmGdGT/FY70O0e6LVZHIF2rDVkGB7tIYrwLG9cGa44jTLIPFF/Zbe0c1f71/PhqkVvMz74tvjfWeuONP6XYQE1ZvYj6TWV+3I0iaMcm8UkBRxkB/qKcg0L6Qmt3O4v0ogvbEjDZUbbnGzNR1thT2f2ZcFILp4QOCadk1gIvMIvUBaZs/uFJuh1mXf4act7Am4RoJrDQJdj//wOxf0lb54iYtkZnWUKBw3vt2bEvGjv/d5Oy5JYRbznnm/hxlMebvBlAHtMiN9MGesGduLT+R3B7Pr8g4J37+0GOsJeywW3HkWkGixwRGMhlZP8ZQzxXXs2z2RMm2ostHdnifhmgQGv+TSl7XAWSByTMX6elH8EcpRPmq7A1i5/nlc0L9OoC0DSElt26cg/60SRa4qphbhG+Amz0clRE9GQa8FU1oWgqZ/DS0YYVbX0MdN6cR/hyD1da0eY+zFzv8QT1WxARc18E9wEJ2ZA1SV+PnSaKtOm48J1zpcV2D+NMX9mWf5Q8CHAtlv2S0lxP224SmvXvII2RCX0XpbHooHzCPxuFmmviVt0GAZODkfnYdxlWrDmzIVVvm/yByQcpOpBcxf4MoI39cXoG4uR2LFPbtA61+xzR9IhQ3zflfCaAs0lKRWe3Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR02MB8550.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(122000001)(71200400001)(82960400001)(6506007)(2906002)(478600001)(66556008)(91956017)(76116006)(66946007)(6512007)(8676002)(8936002)(6916009)(316002)(4326008)(66476007)(66446008)(64756008)(5660300002)(6486002)(41300700001)(2616005)(26005)(83380400001)(33656002)(86362001)(36756003)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTQ3L3F0OEpndVRWRG1SNndtdmg4cWpCVjFIL3A5Yk9qeE5OaGFPNWpybXdn?=
 =?utf-8?B?WCtqbnRsZlpVR29aWkF5aiswOWFFMUIreGFoVXpQcVFtb0pNZXlnT1h1ejJr?=
 =?utf-8?B?WDRoa2JVOWdQUXVPTGZtVFg4eVZSQmVaU1d5cW1SVHI0MEp6clhCamxkSGYw?=
 =?utf-8?B?RTA5dENMYkNSOThOVmhRYjRrUHljb3ZaOWZpYmNPYSs3elBpemd0THE4blpJ?=
 =?utf-8?B?QWZGeE02WEtndml1T1h5MTlqcWpxK3MvVCswRjRPZzRCeUtCZSsxTkRuUnVi?=
 =?utf-8?B?QmtodDFOY2FSVjhFbW1XRE9kMXBobFpUMFZWa08zQVpHL0tiQ2lMWEFTVEMv?=
 =?utf-8?B?cVMxVm9WUUNFVlNwLzdOWmNEQVFWMW1DYlFXdDhQY2pFN1RjWEd3UDdaQVhL?=
 =?utf-8?B?SStHa3pCU1duV2FYSGtsS0RYeHBHV0l1dXF1dnZ4TzBNUWhvVjhzc29KK2d4?=
 =?utf-8?B?REhFTWhCQy8yNk1ra1VENDZKWHhOTFFRQWt1MU4wODA0Umh6WnFCT1FTQ2x1?=
 =?utf-8?B?cWpNdFR3dWdMNE9KRE9aSHltUUkzL291R2J3ak8yK0hiSWZxeDhwN0p0S1E0?=
 =?utf-8?B?dmxqc2hpc21HV0tWcndIa2N4UzVlRThuckx0VjRnZm5mNlZxS2NyajB4U3Ja?=
 =?utf-8?B?anhTK1RuUzZFV0haeEx3RVpSMnBmazZ3SGdBZDBwRENLSWxLZXF1ZHBtaTg3?=
 =?utf-8?B?OG9ieW9wZHAwWXJmRE1RUVNHOE91bXp0d0padzE3d2F5NitUTWdzSEZzVmsw?=
 =?utf-8?B?bkdQYWFSZm9INUVpUjU2dC9saGlOYUtiU1k2OXFZWXNyUHU2VG51QUZ3N1Q0?=
 =?utf-8?B?eGNLeUp5eVdTTzZEWXVoc3k1VWdaYzRCYlBET01Wem55MGU4WE9SQ0xRWjRX?=
 =?utf-8?B?RHkzd2JReFhCamZ4N08rK1I5MHdWR0N1VXkrSndWNG00MklSek1MODVmT0ZY?=
 =?utf-8?B?NVhLajhNVmVxSFJzalY0dVR4TlkzY2xzVXNhcjJMUDZEbUEyeHQ4akZ2ZU5Q?=
 =?utf-8?B?RUJyRmJIRnFiWGNwYlduK2tUQTJKbWkwb0o4SjhsTDhpamFuTFBKejZxU0M1?=
 =?utf-8?B?c0pYVnpDQzYxY3QwZDZyQWxxaEdLcVZqQjd4Wkk4TlVCVFNUajhNekJteDJw?=
 =?utf-8?B?SFdXRHVtWWVDdkZ1TnV1ZHl2VVdqQzJsRUZVM3NLcGp1VytyV0RJMFJRaDNH?=
 =?utf-8?B?cEZXWTMxcU0vRUFWRk1tcldXejFOYTF3bk1JNS9XSkczdjBGWlFBVzBERTVS?=
 =?utf-8?B?YjN0NW9mWEpqNDRwNkU2SldhZnM5NUtHRlRLaS9wNXd1TmQyaDZ3cXFjdk1i?=
 =?utf-8?B?UkNsa285WVh0WGxjYkxhNFUzeTBnMXVZbWNaVnFLRklnSUd6ZnhiWFpjcjg3?=
 =?utf-8?B?VHlBMVFXb0h2bUlFMGlxVTVHOVNONUcrdFY3NTBQU1ZuYUVwa254SGlhVEkv?=
 =?utf-8?B?NTl2STZyS2Z2ZWU3UGNtZVV2enZHaWtxQWVzZy9DUVBBNXpyNkYzZUtoNW4y?=
 =?utf-8?B?a1phaXF4ektzN1dYM0hTRVhBY1gzMEdFcnptekhzMzdTUEMyMDFnVkNwQWoz?=
 =?utf-8?B?YlFGVWZ4Y3VCc0JVYm1UUi92eDR6WG9ZWkVpZXF0RGRMa2xwb0lnRCtLODk0?=
 =?utf-8?B?dlRSZFJhbG5WRjJub0lQQTdINjZFNzd4VytJd2lFZHpmRUNMRlRkcUJMbmZW?=
 =?utf-8?B?cXVqSmY0WUpRUWVMUUdhK0VKdGdxb2cxK0Nucm9DcHBsalhzQkwxU1A3dk95?=
 =?utf-8?B?WGg0U1BnLzhvOXJnMFVSMU15b3NuU2lUNXUxYVJnZ0xlZVpPUEVFM2VyM3M1?=
 =?utf-8?B?RnVtUHJDOU1MOXQ4OHVmYk9UVkZlOEZCeGRlVEFMa0I1U3ZUYzFIdllHRHQw?=
 =?utf-8?B?MVkzRXRDTGpleTVFSWRNSHZyNng1MkxFZGpKdFRnemtBN0NybGZFQzVBN2Yz?=
 =?utf-8?B?K1I2c1l4TzNPaXRnVGYxTFhaRzJoaFhDZDY2UDhHcnAwUkxzZWtNOXFQelZu?=
 =?utf-8?B?bEwzNC9LRGJHYXpQYWFHVmVPcHF3d01xK1ova2Z3ZUJYbHhMVlF4U0ZUU1FX?=
 =?utf-8?B?NGQ3MFluUG1xdnEycU5XU1d1L3lZVUVOciswQ2UrZzVQVDAzZ2hIRDYrOTVa?=
 =?utf-8?B?WFFaeHRPbUQvZnZnV1RuWUtyYSs2Mnk2amREc2FVNTJjdGplcUNHUllKb3dS?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0DD13E066860D4E9228A2B83AD15135@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB8550.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a709570-5be8-4497-74b6-08dc11f2c339
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 15:42:33.4257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHtNYkYG9gkAQKsvDIYQvojBPKe2TByQn0im35DKzVe1rQhdWteQLCo7aMdxCqivL+YR/jsGfuXRV+1u3YO+gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7272

SGkgS2FyZWwsDQoNCg0KPiBPbiA0LiBKYW4gMjAyNCwgYXQgMTM6MTIsIEthcmVsIFphayA8a3ph
a0ByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgRGVjIDE1LCAyMDIzIGF0IDExOjE4
OjI5UE0gKzAxMDAsIE1pY2hhZWwgVHJhcHAgd3JvdGU6DQo+PiBjb250X2Nsb2NrIHJlcXVpcmVz
IGEgY29ycmVjdCB0aW1lIHNldHVwIGFuZCB0aGVyZWZvcmUgaXQNCj4+IG11c3QgYmUgcG9zc2li
bGUgdG8gZGV0ZWN0IGEgc3RlcCBiYWNrIGJldHdlZW4gdXVpZGQgc3RhcnRzLg0KPj4gLi4uDQo+
PiArIGVudW0geyBmZF9pbml0ID0gLTIsIGZkX2Vycm9yID0gLTEgfTsNCj4gDQo+IEluIHRoZSBj
b2RlIChiZWxvdykgdGhlIGVudW0gaXRlbXMgc2VlbXMgbGlrZSB2YXJpYWJsZXMsIGEgbGl0dGxl
IGJpdA0KPiBjb25mdXNpbmcuIEl0IHdvdWxkIGJlIGJldHRlciB1c2UgdXBwZXItY2FzZSwgU1RB
VEVfRkRfSU5JVCwgU1RBVEVfRkRfRVJST1IuDQo+PiArIHN0YXRpYyBpbnQgc3RhdGVfZmQgPSBm
ZF9pbml0Ow0KPj4gLi4uDQo+PiArIGlmIChzdGF0ZV9mZCA9PSBmZF9lcnJvcikNCg0KTWFrZXMg
c2Vuc2UgYW5kIHdpbGwgYmUgZml4ZWQuDQoNCj4+IC4uLg0KPj4gKyBzYXZlX3VtYXNrID0gdW1h
c2soMCk7DQo+PiArIHN0YXRlX2ZkID0gb3BlbihMSUJVVUlEX0NMT0NLX0NPTlRfRklMRSwgT19S
RFdSfE9fQ1JFQVR8T19DTE9FWEVDLCAwNjYwKTsNCj4+ICsgKHZvaWQpIHVtYXNrKHNhdmVfdW1h
c2spOw0KPj4gKyBpZiAoc3RhdGVfZmQgPT0gZmRfZXJyb3IpDQo+PiArIHJldHVybiAtMTsNCj4+
ICsNCj4+ICsgc3RhdGVfZiA9IGZkb3BlbihzdGF0ZV9mZCwgInIrIiBVTF9DTE9FWEVDU1RSKTsN
Cj4+ICsgaWYgKCFzdGF0ZV9mKQ0KPj4gKyBnb3RvIGVycm9yOw0KPiANCj4gU2VlbXMgaXQgZHVw
bGljYXRlcyBjb2RlIGZyb20gZ2V0X2Nsb2NrKCksIHdoYXQgYWJvdXQgaW50cm9kdWNlIGEgZ2Vu
ZXJpYw0KPiANCj4gICAgc3RhdGVfZmRfaW5pdChMSUJVVUlEX0NMT0NLX0NPTlRfRklMRSwgJnN0
YXRlX2ZkLCAmc3RhdGVfZik7DQo+IA0KPiBhbmQgdXNlIHRoZSBzYW1lIGluIGdldF9jbG9jaygp
IGZvciBMSUJVVUlEX0NMT0NLX0ZJTEU/DQoNClRoYXTigJlzIHRoZSBjYXNlIGZvciB0aGUgaW5p
dGlhbGl6YXRpb24gd2l0aCBvcGVuKCkvZmRvcGVuKCkuDQpJ4oCZbGwgbW92ZSB0aGlzIGludG8g
dGhlIG5ldyBmdW5jdGlvbiBzdGF0ZV9mZF9pbml0KCkuDQoNCj4+ICsgaWYgKGZzdGF0KHN0YXRl
X2ZkLCAmc3QpKQ0KPj4gKyBnb3RvIGVycm9yOw0KPj4gKw0KPj4gKyBpZiAoc3Quc3Rfc2l6ZSkg
ew0KPj4gKyByZXdpbmQoc3RhdGVfZik7DQo+PiArIGlmIChmc2NhbmYoc3RhdGVfZiwgImNvbnQ6
ICVsdVxuIiwgJmxhc3RfY2xvY2tfcmVnKSAhPSAxKQ0KPj4gKyBnb3RvIGVycm9yOw0KPj4gKyB9
IGVsc2UNCj4+ICsgbGFzdF9jbG9ja19yZWcgPSBjbG9ja19yZWc7DQo+IA0KPiBGb3IgTElCVVVJ
RF9DTE9DS19GSUxFIHdlIHVzZSBmbG9jaygpLCBJIGd1ZXNzIGl0J3MgdW5uZWNlc3NhcnkgZm9y
DQo+IExJQlVVSURfQ0xPQ0tfQ09OVF9GSUxFIGFzIHdlIGFzc3VtZSBvbmx5IG9uZSB1dWlkZCBp
bnN0YW5jZSwgcmlnaHQ/DQoNClRoYXTigJlzIGNvcnJlY3QsIGJhc2VkIG9uIHRoZSBjaGVjayBp
biB1dWlkZC5jLCB0aGVyZSBjYW4ndCBiZSBtdWx0aXBsZSBpbnN0YW5jZXMuDQoNCg0KDQpNaWNo
YWVsDQoNCg0KDQoNCg==
