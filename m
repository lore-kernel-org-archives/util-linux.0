Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B48C433EF
	for <util-linux@archiver.kernel.org>; Tue, 12 Apr 2022 05:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiDLFCR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Apr 2022 01:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347391AbiDLFCN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 Apr 2022 01:02:13 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08olkn2076.outbound.protection.outlook.com [40.92.47.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1795340FF
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 21:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKuC1sb9o90sl121chTaWs0sATD0tQiDq39hbeCDjTP4q+8GxP4Mj6L1CaV+FHXqiAbG1acI2pJvH/bzUAcQJcY3hzQAGf2vXwgyNQDaVLXrju/bo2xaKdn0a1NfKvSG0PEt0KuMksJ3sK10vN0PsiUo1RYeKhmjetkReMLFa6jlbEEgNN40ZZuWw3PX/T9wiImJxjyf3Z6sX6/BlI8Yl+OqL9Q/K+SnCtpxQg/DOc345HFCKIk1pKowk4if7DNAQjS9M1XqnPkZzgA2V/cCswKoJcyreWNmnEM6Rv8kh1oMu3L++dkZCY7HQOlESIk66S6Il1q9ys4vdYccR22wCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n71bFNJhdMF5sffjfXA0S00XuXFKeoADyUaOfD+XsNI=;
 b=iFOphSjDpZrlnPu9iG6lS8IKg0VYy0HQVVfC2EjtoZNt58irkKJBg5yxdtRCzdqghCQwnuG+sNkeK1ockkmymEg4EPZ9JDin1SkTXcWJuWXPVXf9xbqZnwNPz4w9FKrPcGw8s45jDA2Nd+0FE6hjSa+CKO0yfG4PLBUN88TZXwrxD9kcSLcs/VAH2Ug3ghC4u7x4QVJQqI2sm6T+qTJG30EytKYCTkh4dznu+srW23w0/f3Yq39/Dk8QyHanXj00VhutK8NdMI8rYji+Pku1NSNWoJYiR9Hs26w4fAQ769/Wi4FYocgJ1ZZpTTjzu+x6bzsyVm1fBUzs7TdTGYOD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n71bFNJhdMF5sffjfXA0S00XuXFKeoADyUaOfD+XsNI=;
 b=YVJMGJoD29pZm5mCmb0CNUVyfAeH34TVcNCxtJzgVw6H19XxSy4aZiaDSrX2dkje022lxsNGET2svlNsIrTGC0l+clchn/OpFM0YzJVflV3t9U9jm/i8FOVEvD+7640iZLNIOUxI0JaKsIMGUQ1oR8hxsjSwQ/3yy0igf5tqUj09MDIc7uc2lojA1Ur+fhqqVGodX5EmlkXa6Vscqpq6B+kw8umCmagdYaRSP8x/FD8spfaKB7lL0wTTQNZgLReG8J7o9BPUzItzFGR6/ICJYaGvInGkXTtlJZB4d8J6kwp2lmn5R6q6JzLnzND4VLSlgzSt8nziIgYXsP1S4v4PMA==
Received: from SN6PR04MB3983.namprd04.prod.outlook.com (2603:10b6:805:4c::19)
 by BL0PR04MB5043.namprd04.prod.outlook.com (2603:10b6:208:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 04:59:53 +0000
Received: from SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::5102:79c8:1ec5:d316]) by SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::5102:79c8:1ec5:d316%5]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 04:59:53 +0000
From:   Nathan Sharp <nwsharp@live.com>
To:     util-linux@vger.kernel.org
Cc:     Nathan Sharp <nwsharp@live.com>
Subject: [PATCH RFC 4/4] pipesz: add bash-completion script
Date:   Mon, 11 Apr 2022 22:59:30 -0600
Message-ID: <SN6PR04MB39838B437662DE2EDD999740C2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412045930.236051-1-nwsharp@live.com>
References: <20220412045930.236051-1-nwsharp@live.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [P8UauzAd22OwdKArcXv7XcQyEur3MMt1]
X-ClientProxiedBy: CH2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:610:4c::25) To SN6PR04MB3983.namprd04.prod.outlook.com
 (2603:10b6:805:4c::19)
X-Microsoft-Original-Message-ID: <20220412045930.236051-5-nwsharp@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abde4ceb-52aa-47df-93f3-08da1c414801
X-MS-Exchange-SLBlob-MailProps: gjx25WM8ZNWTUkYsfs8LU6BtPgaYLwsWwQjzhXIApFUa/iNBq71Iv19YgiVWV35WUV7sPmBH0zGuBgWdwz1UCRCypcKtLLMJMIVXEAWk1+iDX190Sp2KvFJTLcvce3xEzj7fsfrnH9SIfgmTu7+NQucjhrgW8kisX2TqXPfPpjcjzw7ZwbtV7G7a6v7hwaWPLqSVUEt/6Rrl/ctUYfafbtsHx+oeMNMlp6YOMKhp6eVSn2qStC9feY8FHUjHd+ZfAKDJE4/JO+t+vc8bi6Xah6817MAbuI9XtAPXiv7RnPzPVjb59UG9Hp2m9vDylDNACrwFEJiSmAancqj4rbGYshjFPUKy8TIPq+DUDAFNMxtjzar7nV8NHi3vntwai5Lnxr1jhviRR6WDk8ABSgtzSyp/TnpcWXd3AbUHWA7qv+aMfvJDglcKfF845SX9JxJMxyGRfjhWAo2HAmX56FeyxKXzkjbZsq6VB8SYaLJOVwSy3Xpdz80z582enS+d7cakNebItszj44sZcl6VFbld6hYCY/NLB/pHNIkTX55VfZZCPe76Yo3zWEnN1U6zI+JN4m4Dud1FomDY+LwgM1Har5HyF6G0vSBXqMqvAKYf1NevEvjTl4c3VTAsT3WPmyfV0YkojbaX/TuLHitjOgxUYY6mLLUmbqHw1X5FS1JUrxagtdA9Ydl3qa9pa4euHkzpDCGnhhOvtVCGlHyNj2I36evlhhOlm++V05RVUzSQ3LM=
X-MS-TrafficTypeDiagnostic: BL0PR04MB5043:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPhyFBLF/Cn4MREkIUJ9C0/iOvkhOknV5CihyLX1rFXR8jOVSdukphLJupoclagYQtuXRqlQgKyeEBtlslDMG/fUfaoUy4Kwov70yofFTyrZ3nS+oC/vSawpkc6hJkjD5yp/J8Oftq7M85BetoJ5Yw/FaTFNtBKFWuQ+zd4P17y3rHHLuupKcSseR3iunmDjATp0+LndJ8LVuLfsTVARFOb5X88bF7D/8RoiScRKv2catj7o0Y4xipg+tKoJFOZnnvVqz1cJJ6oYYwG+IgPj5D/agtsEZpSz9liyqskj7vx1Wt5NClNglK4Szrtiv1gYp5EaTfs+6ogXuOLcvVD3Tn0gbSuyNXnhhcGWi94TWUfVl6maJZA6fmvfB+hsziMpVzFiyzKlgEckC7gnj0nO1XWLi5b45I5blBsv1hYpD37ynkGabhMqZ1l6MOpAhBSfZWZGK+M1Lt7n4AYZdu/tDrmvw8JSKfJKwljuG5jWkg8xtQd22vmxygGEMnyD7hME0G81L+wfrJL63oQrwAhUkqcOAmDdVzyenhs7WDqGaTNJJOiRrC1Jc0JZKvx3FKmth/DF1X1P05LRBA7QTlWwMQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eS+zS6lwMF64BzJvIeRik/aSTyUlLHKB3XOAfDFtQM360iZGJnBTbjXkF0I2?=
 =?us-ascii?Q?lzn3XxeOwVL4DxPCeVdt982kRI5/9LOXv3aAfAc+Ujf6nDaYwA8gl43XiA/B?=
 =?us-ascii?Q?8+1KBEEe4q3Z67DnE+ovDu/0v/UctSfo72AVHn1RWPy6nGHnVKhA0CVf6zmF?=
 =?us-ascii?Q?rGqrKTI8uucL32u4fOm0L4tfU2Jz+O0tlzc2TtLnkTVRUQTDUuDjI7OWu7Gb?=
 =?us-ascii?Q?ALMBbYvqMye7S6KL/6nTfDhX78KalvVznzfoorhk2WGrbuuazUIZ3XqS5toc?=
 =?us-ascii?Q?Bj9WnxmKcEYsj58XpjIZiJKGP14EE2PP3CIcVZYjj5RyWT/PU40EiwgUOV31?=
 =?us-ascii?Q?3xqRUjTFbSYz/VOBvC1L0FVZuIH0Rjpmc8mUA26QxhIjL1ze827Z7D6jsi7C?=
 =?us-ascii?Q?SitSZl/APiTQd8oaWMqiSbdt/13XnpZmor3HiJRKRfZ3IJrlVT+nSEgJW8TD?=
 =?us-ascii?Q?70A1GTzET64m6GL/mP6hVMw0X3ufh2KWGE+1IGaC08F5pM9YYedutDyYxQku?=
 =?us-ascii?Q?/ZV5g++9KKfTxX35aJzCm+NGVz8jukM+qcDV3tWsFAHY/PGO0LT0FE4grLYe?=
 =?us-ascii?Q?GGEUVovKDIBPe8S+9BtELaoftewcr6uWG9weVtqD1Cielkozo25Vhfnug0MN?=
 =?us-ascii?Q?2El1lMaY4UD/9xHJSxrAWFnl7Oezpfhlc82cuw7fYIbHsJZ2r1sBBMbV8oml?=
 =?us-ascii?Q?vZs2AfmxzpqInYgtZ7jaI0gVd9cYIax9G2R3pp58xzpuEaCHbqjdO0mO8Gaj?=
 =?us-ascii?Q?CBy/ssnHarHLSO3RVNEyt/sDy4KGosV/lgUSvp2lazRWVHBrBAONQilkwk7B?=
 =?us-ascii?Q?peM4EzZzxTIH00ccYFmU438Zy3Y62U2RcnUNGCs4UPzsDCfIPULTNd/lLRH5?=
 =?us-ascii?Q?X3x1MuAPhAJCaJ/LNAv2BYalktxO8Q3PR6DnBh76iaVvYbbhBGDJClInSPCx?=
 =?us-ascii?Q?ElA325yMuK1tbcdOnPaIGBW9FGIXIlVqNk+Im3A/+kcHdqEPh5ORf/98IUZF?=
 =?us-ascii?Q?UUOGV4fYsELauNB0q3UrOettyUuUTZckhdMqkmB+r0iIfBMcUQ0QsOiXUxcl?=
 =?us-ascii?Q?HUIcA8QbXF9DrUVjfe0YIFg5E0JWKdUuLwJZTe1NOVxz2l5d3bOBaBi+niy8?=
 =?us-ascii?Q?7obt/IeSm+3TMnG6o/krm0GWwdxMqiRFCcnaw90lEBP19PqZPoyn51Lbu9Gg?=
 =?us-ascii?Q?E4YmdTQD8NEF2lbtbFm6eNoXUhRDIg5kzSnsPZmv8WHGSWn+5Ah3jucctXuD?=
 =?us-ascii?Q?iwmXwFmulwZKPZY3z8Znijlbc5+sr3ZRv0Ta3AlU8V/H5ekUx7xr704c9gtx?=
 =?us-ascii?Q?An2Qtf/RZRwqzLlCpzhxmsVC9bwARXCOJG+bgz+dSX0blgvrtKP5etMSC87M?=
 =?us-ascii?Q?SqtAPYPLnlNvhnuIiNsldVFmp/6BSNugzIVflBcamrUDBPpPAaByNhCcj4m/?=
 =?us-ascii?Q?Kqvb8+WuaUo=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: abde4ceb-52aa-47df-93f3-08da1c414801
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB3983.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 04:59:53.5986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5043
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Nathan Sharp <nwsharp@live.com>
---
 bash-completion/Makemodule.am |   3 +
 bash-completion/pipesz        | 102 ++++++++++++++++++++++++++++++++++
 meson.build                   |   1 +
 3 files changed, 106 insertions(+)
 create mode 100644 bash-completion/pipesz

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index f852114..5d59b55 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -335,5 +335,8 @@ endif
 if BUILD_HARDLINK
 dist_bashcompletion_DATA += bash-completion/hardlink
 endif
+if BUILD_PIPESZ
+dist_bashcompletion_DATA += bash-completion/pipesz
+endif
 
 endif # BUILD_BASH_COMPLETION
diff --git a/bash-completion/pipesz b/bash-completion/pipesz
new file mode 100644
index 0000000..592075c
--- /dev/null
+++ b/bash-completion/pipesz
@@ -0,0 +1,102 @@
+_pipesz_module()
+{
+	local WORD OPTS OPTARG OPTEND SOPT LOPT TARG
+	local SOPTS=(g s f n i o e c q v h V)
+	local LOPTS=(get set file fd stdin stdout stderr check quiet verbose help version)
+	local AOPTS=(0 1 1 1 0 0 0 0 0 0 0 0) # takes argument
+	local TOPTS=(1 0 1 1 1 1 1 0 0 0 0 0) # specifies target
+	local XOPTS=(0 0 0 0 0 0 0 0 0 0 1 1) # exits immediately
+	local MOPTS=(0 0 1 1 0 0 0 0 0 0 0 0) # repeatable
+	local NOPTS=(0 0 0 0 0 0 0 0 0 0 0 0) # number of repeats
+	local IDXG=0 IDXS=1                   # index of --get and --set
+
+	for ((i=1; i<COMP_CWORD; i++)); do
+		WORD=${COMP_WORDS[i]}
+
+		if [[ ${NOPTS[$IDXG]} -eq 0 ]]; then
+			case $WORD in
+				--)
+					_command_offset $((i+1))
+					return 0;;
+				[^-]*)
+					_command_offset $i
+					return 0;;
+			esac
+		fi
+
+		for ((j=0; j<${#NOPTS[@]}; j++)); do
+			SOPT=${SOPTS[$j]}
+			LOPT=${LOPTS[$j]}
+
+			case $WORD in
+				--$LOPT) OPTEND=l;;
+				--*) continue;;
+				-*$SOPT) OPTEND=s;;
+				-*$SOPT*) OPTEND=n;;
+				*) continue;;
+			esac
+
+			if [[ ${XOPTS[$j]} -ne 0 ]]; then
+				COMPREPLY=()
+				return 0
+			fi
+
+			((NOPTS[j]++))
+
+			[[ ${TOPTS[$j]} -ne 0 ]] && TARG=y
+			[[ $OPTEND != n ]] && ((i+=AOPTS[j]))
+			[[ $OPTEND == l ]] && break
+		done
+	done
+
+	case $3 in
+		--fd) OPTARG=n;;
+		--file) OPTARG=f;;
+		--size) OPTARG=s;;
+		--*) ;;
+		-*n) OPTARG=n;;
+		-*f) OPTARG=f;;
+		-*s) OPTARG=s;;
+	esac
+
+	case $OPTARG in
+		f)
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- "$2") )
+			return 0;;
+		n)
+			COMPREPLY=( $(compgen -W "0 1 2" -- "$2") )
+			return 0;;
+		s)
+			WORD=$2
+			if [[ ! $WORD =~ ^[0-9]+[a-zA-Z]*$ ]]; then
+				COMPREPLY=()
+				return 0
+			fi
+
+			while [[ $WORD =~ [a-zA-Z]$ ]]; do WORD=${WORD:0:-1}; done
+
+			compopt -o nosort
+			COMPREPLY=( $(compgen -W "$WORD $WORD{K,M,G}{B,iB}" -- "$2") )
+			return 0;;
+	esac
+
+	for ((j=0; j<${#NOPTS[@]}; j++)); do
+		[[ $j -eq $IDXG && ${NOPTS[$IDXS]} -ne 0 ]] && continue
+		[[ $j -eq $IDXS && ${NOPTS[$IDXG]} -ne 0 ]] && continue
+		[[ $COMP_CWORD -ne 1 && ${XOPTS[$j]} -ne 0 ]] && continue
+		[[ ${NOPTS[$j]} -gt 0 && ${MOPTS[$j]} -eq 0 ]] && continue
+
+		[[ $2 != --* && $2 == -* ]] && OPTS+=" -${SOPTS[$j]}"
+		OPTS+=" --${LOPTS[$j]}"
+	done
+
+	if [[ ! $TARG || ${NOPTS[$IDXG]} -ne 0 ]]; then
+		COMPREPLY=( $(compgen -W "$OPTS" -- "$2") )
+	else
+		compopt -o filenames
+		COMPREPLY=( $(compgen -c -W "$OPTS --" -- "$2") )
+	fi
+}
+
+complete -F _pipesz_module pipesz
diff --git a/meson.build b/meson.build
index a94b02f..58b8ea6 100644
--- a/meson.build
+++ b/meson.build
@@ -2689,6 +2689,7 @@ exe = executable(
 if opt and not is_disabler(exe)
   exes += exe
   manadocs += ['misc-utils/pipesz.1.adoc']
+  bashcompletions += ['pipesz']
 endif
 
 exe = executable(
-- 
2.35.1

