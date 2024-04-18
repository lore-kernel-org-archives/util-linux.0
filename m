Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772851EEE4
	for <util-linux@vger.kernel.org>; Thu, 18 Apr 2024 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430188; cv=fail; b=ukiaLs79GgT6IhgqxUyeFoQzE91L+fn6ATaAg8p6bnUvFVqWwZ2uOc6GZXenzFd2YROCNXH07YXmHF3zaR2kWBHqpPxKoCzrWeQ9JO216B/4LZAsPsx5lU7/0gnOWuSfQkqQpBbI6G+VmvHplFiBLE68lsPDNvpceaBf1L9FmiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430188; c=relaxed/simple;
	bh=w3PmscYFhsiHzpVTPc8z9LD4L5ZbRJxPTIoqLcvVQNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nlm9WJIkxjgB/QnETTKGrWJqNoSehi2Pxmshv2lwZVMUojm1esp5N0sLHkcz3v0eXn+HKdrN9jbOJC7GjeOsQltbOzpJEvF9Rtn6l62b66H7yN5eQGHUhgMK6O85hLArco4WI6vCHfqyTT+5tsuUhaApDtF/fYysQB6cEvI3zeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=UX2SgseY; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="UX2SgseY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Agg9HhBjnuZ6HkmB0aYVZcM4NnLaTbz3pC9bQ50HozCb+XlGTqYeVLwSRgN4bQnoLtnh/9ajpIbP0Hxxm6/dzHJpVyhXCmdLBPqfLlBcC9b1Sm6vtx6DeC0LXCzCqgbPEHi3eCM0BhtYfd4Y4CGlU3CWkm2jxvf/pThnwMoDAKo6I2FQkf9Ar2tnFlqcTdc+5a4vipcpKFJquJTdQ6KWBObGPq9RqeViWWKlS6bwDMEJ2dWXfIT3fhCv4Bu2OcauoveNwQR2SLwCyFXe/GVk29sFeFsixfTmVyXEP4iJxw7KMmNfo5Zv5cCo0f3MprK2lafek+8auHFwUlU4qxJfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VNziVpxBoEUM6AEmi9I2yCtFJNEqkldRt6OODcja7Y=;
 b=Q8FcBbv94g7o/17gn6LwxJMeUYPT+rERvgr6fwFmjrLv0wYVKgsXp/OLRtJ4krf59Rm7xDlLiUrBOLPAPEOEMSbDYhzO5D3SgL1/QRvsSuRfEVx1BNVYpAqmDGP4sqaK9swHznlevS71WZOAPuc8uLWg4JPhXFv0K00MTgmnJN5784PIg/93gft8rq/4qDcBFHtBxKL738H3cHBVsC/gndNAa7UYDKbijZK7IgPm3pHfqVBtYBgCdefdjvcZ4mfrmKiTbgaw/w0pqb3vXvyUyCdsObrzeLU/fVCbRGSH2HFwZUK3dZmA8PmG3f9LEvo2hKsFAeakRAmYJLkqIDmjCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VNziVpxBoEUM6AEmi9I2yCtFJNEqkldRt6OODcja7Y=;
 b=UX2SgseYUPdEQtnSZA2GNtVw6Ooi71uuRzUGjGg8zl5ztmMGO4VkpNGo6PKcZ2DMWnmg3Nj6CWuXErU3uSVGC/nK4pUcS3rhv0LJG7M4ujoH3olFbbL1k5irL7HZPx1KBc8Gq/baoqQAnpMAR4Sg+9U6a4LyuM+tNvHQL9ym1Ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAVPR10MB7380.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 08:49:38 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809%6]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 08:49:38 +0000
Message-ID: <1d16b5f4-1d65-49ac-93a7-0f3c158a82a0@prevas.dk>
Date: Thu, 18 Apr 2024 10:49:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] flock: add support for using fcntl() with open file
 description locks
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Masatake YAMATO <yamato@redhat.com>
References: <20240417100948.75817-1-rasmus.villemoes@prevas.dk>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240417100948.75817-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0053.eurprd03.prod.outlook.com (2603:10a6:208::30)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAVPR10MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bf6f31-aa17-49d3-42dd-08dc5f847aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bj3jaKO0gV5Qxcuwy9FNzVLCKEMnMtaGASfMlB9l4sbFIQPvPk2XdefV2KT2OsSjQRQ3zsKaS21WicsnOduVis1uIKgd/HEvO2c8y5sEo0jrVAPhNtIaDfdEZgqwhlt9daAE6Ppu+WAtbWliL+fPrP5yUuMBYlv6LAuOk5FGJ+i3/otMzoHikSafxO29kzvKWPKKiPO7bBwoGuWiGiJ2zqWnU9W7BH8X2PPfHnU+fZH9dVDsDdY3Ho14O/nI6ooHNPtf0S7HvOZ1MV1hwz/F9I7kjZcJDqwsmWbaWO2kDJG2jxZ7hAndBZPqW2FPS2530e4yOCYxSWztGAkBo1uu3NufUyHsKW0wBWOn5oLVBROhbLwoy6I1jAZ2AqSHOk/mHc1UaLKRdhNApM0MplWGhr71mKOk+odzWOuYBckUEXsEb1scpDe8MiAhx+ePDmo9tm/TcwS6tSnDh7sOKLg3+/bYMAMrB65IAylb6xm0oJyfskLo3qI4eCsqsDBRyoYMyBCDnTfL1SH6wxHNv1gMFJP37ZdVnCgxwL6+F1bhZjTTHrclg6hRAjxcHObzCYs0W79OurRX39T+uLzjj8ZmjbfGxL8pS2+9LuiTds2zJEFmu1uc0p4S3J+rvBfwPIfojpC8LEx8WNlUY1jHEGsdh1EupcuCwxJtWaQLp9aIIWw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjFsOE5jTW1xdVppQ3FIZVM4V3R0Z1J0NEVDbXVSaVA1NDhKZ2kvdWtlRnlq?=
 =?utf-8?B?RVFJc1c3U29MK2MvOFFEc1lxUXVyRXRZS3FoSWl5TVh3ekVLVnpFVll4cU9J?=
 =?utf-8?B?UkZWWVRXVncxUW9hSitrcW5MYTIxenJuUzV0RHE2NU43S3FQSFAvY2ZhZ0tI?=
 =?utf-8?B?d200WWgxSHI2L0p0bXc4a05DUlNEQ01mVWlHZVpySEhpaDVLZ1FCNWpIaG16?=
 =?utf-8?B?VVAzRjBVZUNYWkdzOE45dVNGSkNpRjg4SjhpSWFJYi92MzVldFRpdjAyZmJS?=
 =?utf-8?B?a1IyZUhndlBvVVZxbGdybVNoeXB2MHBSUXRrVnAvUjB0UEFPT0NuUWQrNnJv?=
 =?utf-8?B?RERXc1Zia3k5ZXRSWVR2bERvM1h0dE9PaHhCdTUrNHdYOExEajZsdkFnNUJn?=
 =?utf-8?B?bGtjVGlUb3AxL05uTmVpcFladG9NTXFkOU5YeFNmUU42bWIzVzRiT2lFQVR2?=
 =?utf-8?B?cmhSTERMZzNmZThCbVJzck1Cald5NHRtcXFaMTFSMks1NkI1aFFMR21zMW1x?=
 =?utf-8?B?dVhieWsyZ0V5L1VGTjJEZm1WKzRvVW0xL3NiVGN2TDZkaFJvSnBIZis4QkVN?=
 =?utf-8?B?dnQwYUhJcUZDcE5YVjc2OGRWUkxHbHhZbFRBWjlwTkQ4OWx6VUM3VFlYeWpG?=
 =?utf-8?B?MlI0OVV3S1hrWDBmRVhBemNIMXQyK3BTK2c5d01USklPdERleWFFOTJEaGhC?=
 =?utf-8?B?VWdPWGo0Um1GOGg1anJiNUJDRUpJWGVVdkZGcXl5dzNIUTlSZ1VnS01lQTVn?=
 =?utf-8?B?TjZidkdydjRsTWdCRTczTGdEeG9UdGpqY3ZxWXJVVFoyMkMwK0ZyTjJFckI4?=
 =?utf-8?B?ekMxVzc2RjhEWmw3Q3BudW5HMFZ4eExWRldOSXR5UkNVTzBuNVdZU00vV2cy?=
 =?utf-8?B?ejFxTUswYmczcmszdTlHUW05VjhoeWtENjlZWUYrSTZ2Z0xSb0FDd3lCTjlk?=
 =?utf-8?B?bEZOc3A1dGZnOFVXa0NUYXo1TlR2VG9kWnB1NzRqZi95ZDYyVFFXWkVBWTRK?=
 =?utf-8?B?SE1yczhpTDlqdTRrcDZOVkRwTEw1S1Y3Qk56azBOTFcvSkR6eEpjWkI4SFYy?=
 =?utf-8?B?ZE5HWVdOOUpUWDFDZGJqWlZnNnMzdzlPQ2JSaTRTdnpHQmJlS2F2S2JXekMx?=
 =?utf-8?B?MmpPazFvSFVIQjIydUhJUEJkQi9NNGlPdzdZNU1EN3I4VmVva3FNUStuOUg0?=
 =?utf-8?B?NHNmUGU4bHZvQVhyU0tCRU45TE5iNS8wUDNJeEpiY1Nuc2RJREdVblFZc3pX?=
 =?utf-8?B?aUgxazJMbUFCV3piUVhDeDVXMkMxMnNqelBzOGp2ZE9rZ3ppTStxakxaL214?=
 =?utf-8?B?RkhOREdCd3NxZlRuWE40a2NMS244N1FsNnNjRFBQZW1NUGRhY3dGeFRRQ2xB?=
 =?utf-8?B?S3FxbDhKTGhvdFEzdmVqcDlZZjBscGtHSFMrUG96V0gvU1ZSM3hlQ2xvYnlU?=
 =?utf-8?B?R1JLNURNcGZLbW5FeitWaXVzZmE1dTM4WG9CdEVZZkQzaTk5YlA0akQrd3ZH?=
 =?utf-8?B?VDFTSTlYalI4M3E3SmFZUDNRdmpWbFNYQ21aQ1c2b0xhMk5LclJXTFRGSGNV?=
 =?utf-8?B?dHlHU0NkN285S1FWWFk3T0ZqbWNJQjF4bGxxK1NZeU5KbU5jZElMNjZJMWc0?=
 =?utf-8?B?azNVckJWTlI1NGZQd0dic1dmeDZvSXZ5NTZvN1pBYU9CamFUWm9tMkxrWFMv?=
 =?utf-8?B?aVQrMEpHYXhkNlI1V3VHSCsvd2ttWWk3Y2puR0QvUlRxUWxiMEZESllrczdK?=
 =?utf-8?B?UUI0V1NrV1ZxeUx3bmJPdkFrNDZqWklrL3QxME9hYUtzS1ZnaXVuR3RSYmdP?=
 =?utf-8?B?TVJmaVNDZlZreEFnaFBFMjk2OFEzcU0xRG9wWm1IVlNSc2FrdkI3alhMSVBH?=
 =?utf-8?B?NWErbUJnNW1MYlVQVHg2MlFzNW9rcUphQklCSDYrZFNwMTIzempqNm01RVlD?=
 =?utf-8?B?Wjh4dy9tWjlzZktxYjdRdXNubVNuTTMvWlE4YjAwSUthMXN1U0pkYjJIVmlP?=
 =?utf-8?B?a1Z2QXlzU2h6ZjJqOUVJSWl4QkdzcVhCZitDWklERmVZMWtZbnE0Z2dJVGVj?=
 =?utf-8?B?dXBiQ2M0Y0t0aUtMRjZHSDQ5RjBlaysrZ0hPdVBpeHVMZXIwbnYzSE0ydFhF?=
 =?utf-8?B?cFZrRzVxbzJwVHlKY2pWZDNMNWRVOHgwYm9rLzU5ZnRQNTdVUHNUZ215NjJV?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bf6f31-aa17-49d3-42dd-08dc5f847aa8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 08:49:38.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bWSic/b91rHlHQIT9HuhdSOZOLGHwpDsAG7cxP+HaH6D1mzUYaKnMSk/0dFUJxPA57eu3OB/BZ8v6QTug2zBihPqSea9ermF0eayKT2fro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7380

On 17/04/2024 12.09, Rasmus Villemoes wrote:

> I'm not at all married to the option name. I also considered just
> making it --fcntl, 

Thinking more about it, I think I prefer this slightly shorter name.

with the possiblity of making that grow an optional
> argument (for example --fcntl=posix with plain --fcntl being an alias
> for --fcntl=ofd) 

Not that I'm gonna implement this part immediately, but I do like that
it leaves the door open for it.

If no other comments appear in a day or two, I'll resend with that
change and the fix for guarding the maybe-unused helper function.

Rasmus

