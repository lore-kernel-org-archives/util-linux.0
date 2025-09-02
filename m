Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89812EADC
	for <util-linux@vger.kernel.org>; Tue,  2 Sep 2025 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844923; cv=fail; b=rC8X1KXngSDu0aGEkopX3Zr0bDE4R2li2Zme2lZnALmRhxvuhRfozQbt1AVAeAIE+6kekk9hi6YWErsP5amNjpVaTNG9joGg5AkGa5BVsXs2yV38pF23nZCxYbANT3vIJHfIXE7W9MxPf3x5pzaB5CqElefwhoYcVgQAarp06t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844923; c=relaxed/simple;
	bh=OWBKdt+npkCeKDBNkDwdtuOFqe7AJx5sDncqn88vR3g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZM+KSrk8hWrvEaEoLSobcGBi+APioNGyseg8xS3ougfhRgOgqI5RGshzaiS8P7YyI5DuxTla+6oQ38W9VT63Rs40O/0j1novnhopTfj2513fc0GHCWRM00fa/jMPibifDXuyLd6RRbrBy1ZGjgcdEm5tD80Q/3H8bsR6WEo2fhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RgtR8Y50; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RgtR8Y50"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rw0b2kWTZBLvuI2O4fSS1BUPv2Fm4p4A+jReqWRxiAwUtyHYfPhVm4sVHCe+n9cai6CWUzVljtqP1kYvarCfvs016RVV7UiTfyEJPUvdJ31cL0989SGlhkcOe6bFdAJKx0Jvn9prjCYJUhSTf3sxaL7fqaW3IPEg10p48lWYVVrblKxD0/FxNLwcWGvLnOIrGeEoSC4HeAeqOpr3Fj9nr7dN+CWL2uoO1hsXQo0kgjJHjRbk6iHzalxyGXFZ4yZ+rqWHFA5JSj6W7ZgjCzYE5aGafG2TYm59eCmlKqD6h56LggcOEbo31gJVYsg6EPI/G3YubXbT9XcuF59lujrU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2h/8aHb6zuwzmiNzXlXSjRmgG+ZsQuQRqFfo9rKxxQ=;
 b=jf2zDODq0N6EjwkIhPISxDbhxPxOIFZy5YvW9c/GEkMjRGXUhYIUb0/PwVbaUw8OH0N5d7J1fNom7wNTHa/7vzlXDpcp/dEHHF3OqQwQLfP9jOWiqENVkMtj0vQFkVb39PYQUlQD6u8kEZcmOdryucfYjTnmX4FIyHst5FssyHYjJZJ+YRPfLACXi2N0QdB/DWcTeHeRxHT5sOHVUI2WorUoBYdUJKTyhs4PSaTrRUrBTk9xi0vKDHHaJuWFjyz/7OMTatBiX5yIRsbhKGMGgQC7I3+VleE8aROz0kYxY1a4Lak2Bys26iVHIB/NMYGcBl/EKIBUV/QIqD1L4FSXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2h/8aHb6zuwzmiNzXlXSjRmgG+ZsQuQRqFfo9rKxxQ=;
 b=RgtR8Y50qseSGCXXcgTsc7ehvJQlzQ9wlPmuhfA8WbymaEviY8W7xt+gDmj30wiYiQLtD+hyt+HSTfqCMDRCRyv5OCWlDMX9NPmCmcfUmZvZ91YU+vmLdLuSBuCzgDtVkS/jzAZzjuTcEK9rX/FK9fkmLbBad4IXPLfWhiz1HL8dyo1wz6omBPA+VSkwNfq3TVn+VsnMHJj2L71je7/NC1Gg8VYrxpEvG5QlMYdnstfb+nknNGCgBrgC6gJJE5068kqsByjOlkZF9V/JP06kkh2on9FauYfZJt0vYpureCRdfVVhphAF/NH4JODsxykKllc9FKKOjdXrnLSAEf8H3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 20:28:38 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%6]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 20:28:38 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] lscpu: Add NVIDIA Olympus arm64 core
Date: Tue,  2 Sep 2025 13:28:36 -0700
Message-ID: <20250902202837.831543-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.46.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To MW6PR12MB8897.namprd12.prod.outlook.com
 (2603:10b6:303:24a::19)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8897:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: aecf600a-600c-4c0d-8226-08ddea5f4c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OnzWTfZGIezsc+lgLc9c/Azz3xWwIMo5xDv3kI0xkPl6u6qi0Eue2rJklgrx?=
 =?us-ascii?Q?0olulEBaYv0tUi4LvrSEHDGZEj5Si+xzIEzO7Oii3jhO+svr/5Dx2yImzIoC?=
 =?us-ascii?Q?ug1GBRqHaYZnsoX6/oqilPo3cNB8JV4UYZd5BRJ5vlVvvhjtzG+IOxfhLFU9?=
 =?us-ascii?Q?4NuVIaWlIW3z+Qr+JjmFdPhCjmozMoUPmGcgSKCQjPKyWsMq6tVYlbe8XHlT?=
 =?us-ascii?Q?n9j/rsOcqIVDEZ3vH3ZzaiU6Rw3JEFxws4kKDMfwu89kcMsxw8IJpRhUExTY?=
 =?us-ascii?Q?FPN+vyXcTCPsf1t5P5HQLtpg5hC2Z4jRwemU9xXkVp2iJt5IMwQMpQzlg8cm?=
 =?us-ascii?Q?t8gAynCdXijwrUJGL7f0A4onLUfquiAXq7fvTnp0symk+M/PljDxGmuQJvw+?=
 =?us-ascii?Q?2xrM5Lb9jaOxeuHA7cHea1a41LQNCsoLkzzfuXJkSWvUA34V3I9V5oVnV+qI?=
 =?us-ascii?Q?dXzb9iIhxP2keAvDX6zuPxFeHaWEjFcwMy4Sp5kL92sg2z7EaYO/a/4JQM4v?=
 =?us-ascii?Q?C5NbawTBh5xrRBlg2B60H3L4mZyOOi0U3rU4UsmFCrsZLo0egNfoJn8ktiZJ?=
 =?us-ascii?Q?KbMfTGVIAeOVN+wdsfZjKCDm+4O4Lwo5ZxNjNHhMZ9GiqAXTBZqlTWP46/+Q?=
 =?us-ascii?Q?70Z2fQNJu69Ow7y0bnKVJmYRDa/5xe7jq0KRLm/1iDIpGfSztrUa6R4R8vC2?=
 =?us-ascii?Q?O7Jkbs2WciB7UZLZFfxmD3oeAmwmfD1g7z+Y994SCtTfbz91VuZBifB267cu?=
 =?us-ascii?Q?FWkjqEXRoXWg94cIsn4oEX8LH4tslQvjnDei/M9lTGIhco0spQlOpDH0nKV/?=
 =?us-ascii?Q?QYmoSPGeAdK+JQn8EJjC6jmIscIeHL4oVHvLxMuvV0nwhSZzTAqAYIrtA90y?=
 =?us-ascii?Q?c+Of5GPx85sRz53+BmjAOQyiL2WoCFvmmWn8XZAc7evNyq6NyWThKw12/njZ?=
 =?us-ascii?Q?Reeu4Ubz7oUAPGYk4eDVFkFdHggYmpfN1IbBpt7TIWY6ObU3PSGJF+PIQFfL?=
 =?us-ascii?Q?qHkHnOkqspTelknvb/5HZdu75Q8WFU8x7XB5cfnIEVeaB7gph276gpFj5t8f?=
 =?us-ascii?Q?lBWYF+3b0J93tbslRymGseDSWvjohJpkps8Za7reI7x4xeG1i2L8hzEiaIMB?=
 =?us-ascii?Q?KIhPFaIUjFPkDJc+E7CJjaAuo9N/70AY4nUWns9BuAyaabAnQWwXAC4N2g6A?=
 =?us-ascii?Q?uKW4EOw/O13f1TAyGCT+HT8spI7YZLXj/A4nW8aQyYDavOvPuNv2fxX1w76z?=
 =?us-ascii?Q?rK8ZmkQiEYP/F4BMNBoUOfI6siCRjraSu69p+G4CL/pZbEhY2NOL+r/7/ehV?=
 =?us-ascii?Q?wV2AEdtx/dyneV3sCchkScbrTRBM8ERbHsG6JjN1vZrwKkKdwSC1EkT7/piZ?=
 =?us-ascii?Q?nDgtWx7P+QdsGuV0t0kWl1d7PX8p8m5O+G4HX1kVKxv/xBxr1S2yv2MWS8G7?=
 =?us-ascii?Q?inCMev6lREc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8897.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+bgbDYWGGd2PuAbo1zB92QvHTzv10aS9LdO1hONWM2K7dg1xr4oSpBv1DyeX?=
 =?us-ascii?Q?0fC63N6M2nzPaewJlw8gMkdpsCVzO6Apm5YNHFMcXC+zZKA04aDpXLAZNqzX?=
 =?us-ascii?Q?f+Y1rmzc0thdpo8rd2+8ZYuiXOTD78kjr0zV3iEwq9LIlyV9/C/Eh+wDZ3iN?=
 =?us-ascii?Q?cRFKz1I3dxQesiYXUdLSlQZWrPuFVPJeyEXQXKLSeAEBCsqscLKk97SseTvW?=
 =?us-ascii?Q?5FClIli18KRjiiZcjNadE417ktMTulBLOAPu4T6R7t71FNxlqjhhOx8NqMFV?=
 =?us-ascii?Q?0ABTQccl9NH515E4m6k18unRxJBOaen0tcO++G6AL8GZ/9nK7oXehVU4lEnd?=
 =?us-ascii?Q?Sp4Rh2qmnKC8DWSk0OAuLTp5AIz4em+LLxPIZDReBFqO3LRdZuQfJgBj5oT3?=
 =?us-ascii?Q?t7esR70LKXk9hG6OvzxvfPGsuVfSEIqFttcpROx+OTyEQrS7TkzB3AQ/AE4c?=
 =?us-ascii?Q?R5jy+yNpJhPx+bAs+aATT72fndGkHzThlUwavszAEZAq2SLbZa7L5NmYIQUH?=
 =?us-ascii?Q?OvELChTvMc4Ij3/MNFTNa9guxRQE7fUDA4HbWDcGwUIQgT8QxEwiDsyd9omA?=
 =?us-ascii?Q?1BvuYB5URPpwLCif9qgVTES0Co1Odlh+iTtNUjNDwS95KWapYqNcnk79Mbxj?=
 =?us-ascii?Q?PVYgqUNhTrjjPtAK4RpKjiOdic/R0jqqFtCv8fsIn7gEDUgCf480+GdnxeMz?=
 =?us-ascii?Q?ITMpCzB2JHh3v2PgUmzNxTLqT018rN0kXKIUu5jRGFv6bcU8kn9b97/00PNL?=
 =?us-ascii?Q?BXD8C6m8sk4r4MyZ6m2TvmGTT2iXPjLY1O+qAJgPLeYpEW8cekghObP66bVz?=
 =?us-ascii?Q?BntWjCcVuVX10TyozVvj65jihsMx8hAKWn8Nzi2Rsxl/K2oLave26BdURNC6?=
 =?us-ascii?Q?naQ60z5GThi5pocblL8PieI6Mt2GVQ/n7JA9VxHPQcwZcHhb8ib5j8UiTaqd?=
 =?us-ascii?Q?6TcknVq9V60VyaiNeXrgrKhLwG8fBYIKT8hx7GeOFkjgYeInU+JXMQX+VqgH?=
 =?us-ascii?Q?eSb57hT1zqsGZgXdzpYyV284Pqkaz+OA7YevSJW+7tUn9UWWmyiN9hIq9iyj?=
 =?us-ascii?Q?aW8loehMeegrpBpEaAmzpt0PB4FXhUvrvjAI+5QI7YSkMkZAuXwkbgtJRfoi?=
 =?us-ascii?Q?l/JFL/cpPeqq2uEG+byM42pmvpbLsze2AC0kdR/NUg9ARpn/ARM3sF/mXY1d?=
 =?us-ascii?Q?87ymh83ltcK7HIXXucx4gAA4o3UWRgmRDWovZ8CcM74pvDWLoB1wsy2/AS60?=
 =?us-ascii?Q?jJj3+5poCj7y0Y9AJZjP2yHrXYwoIJiy6tujshUs/Jb38ZUDITm35GlcsMS+?=
 =?us-ascii?Q?0vId/6eUwVXLbdeiVu1+kvd0gjBpl93Z+zkeWRodFhGkttazAPwDESSrvDsH?=
 =?us-ascii?Q?am+GxQCs1LBexhXV+tP+WfeBseW3r0HRB6HAEg3Gx+gXbAiFRIbGg4G+R7N1?=
 =?us-ascii?Q?xlozY0sFq7M+vN2drBoKc9bys0FjsiycDJlgeQngg7cvnh11jq/XeOSN2SgT?=
 =?us-ascii?Q?2YCFRG/qkm0c7vK7k2TjvxZq8iYJwoDoGn5ysKxUemooNANz48VhBQx3gh3Y?=
 =?us-ascii?Q?Lmfj1UfPEdsxf20fWZfyFQ0akDI2zP2WFehyk7ay?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecf600a-600c-4c0d-8226-08ddea5f4c3c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 20:28:37.9929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sabwqYlkCb1L3meuG7g4b3SMWzZyM4/RJf+8jjwMO45GcVwVfZouB2rwyLCENMYc9U33Hium30R65bD8C8MP3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831

Add an entry for NVIDIA Olympus arm64 core.

Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
---
 sys-utils/lscpu-arm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 8745599d4c99..9596691fd4c2 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -171,6 +171,7 @@ static const struct id_part nvidia_part[] = {
     { 0x000, "Denver" },
     { 0x003, "Denver 2" },
     { 0x004, "Carmel" },
+    { 0x010, "Olympus" },
     { -1, "unknown" },
 };
 
-- 
2.46.0

