Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A884FD9
	for <util-linux@vger.kernel.org>; Tue, 23 Apr 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874120; cv=fail; b=E8Dx2klhUpcleMmbVqNoXhRPIwPJweuzeqQsv2w4X51lCK1swdEgQdQAj/2KCa0ZWLKit5/x+K7davbZvasGs101Js2wLfWqLJ7IEUzBcq37+7yKDZv3ZZ86w1rpwxi8OrhsJGWcd29fdSZIwat0zkHqGjZlJYPIoJ6GwRoOaHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874120; c=relaxed/simple;
	bh=GzHxxhA33h9Su4rAujgf8oA4FeZQRclZw7FSBYLDS2I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j5ZLyridKxRykiwGT6enbDMGG7OV3grrkBya8zWxsbiBZdMEkcjSrMGTg97USoa4cWrZWx8BypMJno/2cbGmBYZDXKWrsBjCTMDW5Hup1fsPd4G4Q4n54zdGwwxTXP7IpEa494weXr2qkpKBB89qfS9ymumwEaqR6N12qrWBJxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=LPTM5Lr4; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="LPTM5Lr4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVtuxQ7KL5ZauwoL24AohOdL3Lq7wb5ml/3OX0z78omp8aRGjlbeddelDzi9RFO25dp0trU/sRHve+ktFWxvKcAelcoanQCo+EYakgslOygjZZUgwKFyb6hHt4eqawB3wznzHPLWfoZO7scJy3evfZIw+7U9v8c9If2gXZnqLQ1XPdDMN0HSm20wF+xHzxxU/9jS2TgZR6fzwwqJvDLq4+GcRwQqO71iaZ+8hJ4m5Uka6jfarWLvPkAn9gL+KK0cXdV61bmX1VBQIYOgZYjbG+77fiNAnIrMX65c3Z7tX0EoQeL5WzdF81524aJI7V8M1Dq1s7WYAvqfNd8ZC4/6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXNuaxEJfxvi0bVvl08thNyrwSqHmEkzTSzR1tqCgLA=;
 b=D+ngxJAytFCukou7adpP041rOTBprrfRrkHCGRxSitkvp7XduPQOvCh3FC4KlycE98pQs1sx9Sy1P/RlXvmVCbWfSIaL4paDgDYPV26lW7FI5z2+Edm2IwDpILrbpSU75WvXxTVu+FRBbye5LzoXzLw/vx6kT/zyp+766+royrDhpxpIhRXm8MMILyTWfOllf+J+AVeaG2AB95S2YOpb7gPctWwGm36ILbO0/ZHHDyj3H7680mV7hbyXvgbMQIlirQKE7MOJ98kQBLpK+fydfdf3r4oU8etEDma0YESj9XJAVs6Fy40UNZ9dlpWAKXJuZRiFo5g/ySJQWg5Ir9493A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXNuaxEJfxvi0bVvl08thNyrwSqHmEkzTSzR1tqCgLA=;
 b=LPTM5Lr4kPXzxa8LzZeqexpMvaE1Bqqq7c3goLmBOYLOKJmcjcJPkmhQp4sV3QAwwJBTY9XZ1srwOlXR8tydjNhDN0YykEqStzaj0Sok8HiY+NWPzP84WvAdJKVqoKHb5HorDxHCxtYa1s6r7UJB4U+cIRKXisE9mylNwT7ASWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB5922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 12:08:29 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 12:08:29 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: util-linux@vger.kernel.org
Cc: Masatake YAMATO <yamato@redhat.com>,
	Karel Zak <kzak@redhat.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2] flock: add support for using fcntl() with open file description locks
Date: Tue, 23 Apr 2024 14:08:19 +0200
Message-Id: <20240423120819.571181-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e0dfbd-5021-4e1e-3c7c-08dc638e1642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gaBT0CTrhh9P1lzTkRWTcPA7/5F6Kmh63ZqoAI38lO+mB7C0bvhRFUvFDE97?=
 =?us-ascii?Q?fEILO/Ojoh99G1WiTbj9Ed3GdeUHbxmZImj3eaYRjYRqa/7qpj1v/T+3EPvY?=
 =?us-ascii?Q?XoKy0RO94h2FDqZkIIbxnvgm9XdV+zDeuO84BuIr3ripNsuN+3EZkCYsHboJ?=
 =?us-ascii?Q?JzpwbhAiyn8cqU4PMcZl5ZzHMILMANfdxdYqEfUiyndzNTw7YoZVKrBNmTd4?=
 =?us-ascii?Q?1ahumlyfoxDWrdgA5sKBUfYfTLUqMKRQtqo18uKd7mWKaVFo+kNlVJ5wZTlI?=
 =?us-ascii?Q?ujzpG5NIpLYBH7B5LA64n9NtlhAK+eo2Rc7x5e0R5JhWl1IOadwQUgRc0DGZ?=
 =?us-ascii?Q?iVeBqbVT5ui7x0COL2Vzl+ozalYQqpyr53RI/F/aVnj93YO0GyePzIGXDCaH?=
 =?us-ascii?Q?8QX0dZH/lqE9NkdGgs5BK4ugc5qU0ZaMOsD4WPXmCYOzEm9b588j4oBXq4nL?=
 =?us-ascii?Q?V9yNnEx4JlHYdCMMHd5eKDt6uRZJ8s7IkkvW9uL3QQEY4OOfRtPv26r9lAFr?=
 =?us-ascii?Q?q/kPSkRUNg/BHbXDeBJ7SMLdpXn6/i/bWNn0O5sdOhEtBZQYIEDY3yRKwFet?=
 =?us-ascii?Q?KY2yD+kHikLAcTo28DaK6zE8IV5VVaeVFpmB4fgflcFsj6VWvD87G3JWw7QL?=
 =?us-ascii?Q?5XJR9CIsqV/KgD/ULvYx62RVOf6lp8cxtxd9bpWxbQeK5PEPmdLL9AijxObq?=
 =?us-ascii?Q?81nEt0JMo+nme80bI1GlJ3d3THIVrox4fUuF05GKXabExCBztrSsyjISm0Ai?=
 =?us-ascii?Q?/0EqShCQM7uHl8iFOGHcDgTzhnSkksBoVobw3fhSO4RbS5r3lhoGYen4YG3j?=
 =?us-ascii?Q?QYPETZSKkt4PV9mPu4G0/HYGcRzryFi3OLeGhEGgaR74ysNLWheR/omuB1cF?=
 =?us-ascii?Q?0gjI2DZA7gG79bZ4HTEJDUuWukV2kp6CGGBgTMLL17IvSNDIKf2NlqMurBSo?=
 =?us-ascii?Q?zYXiPCEJkA/gX+RKae5iMWNImvBFLlWcBTlYixEK177B9nzWhyzlLPVa891E?=
 =?us-ascii?Q?SyxP4NOzHnqWa3s8U5nB5rJzT53c7o23dZjP1onVWsuhtkywxRmuO/6Shh8Z?=
 =?us-ascii?Q?EmMZhZl5ntEEami5rAdJxEe69BMwVzI296HF/pD7iJWQEq1HFmNQCBD/j7eh?=
 =?us-ascii?Q?7syw4YkKoF8cb90kYqhKbBsfDW0+YnNNUg1q9X+8J0256GH5v/0xzR/NvA2z?=
 =?us-ascii?Q?XN1P4yv1/bSNsMcd8Fj2X7CiXj4CYB5oGa0s+6uaVbCI/RT7VmF2uihRVAb8?=
 =?us-ascii?Q?hdY2qQTHw01LFWKw19FyIrJJJCZEei1oPVgoh0D0Pf+8i9Jx35NJ9ux9yhIb?=
 =?us-ascii?Q?dhigS+sdK13VJ4rWyf0pf5qd9nmFoqW6TQ+3wLQ6KgN4Qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mN+ubAWCX4vQzpup0tjs5HB0/xEqEhqcaYB+2Y/Ez2b14kJ56yDjd8wzLhfE?=
 =?us-ascii?Q?NvESjTVpYicLEn19lccU88zO94IXpCSNuRY1cdmr/4YiVCZrlm4WnPPU5Kc7?=
 =?us-ascii?Q?X+lMeOwp3/90p1XMOLJ+FGbCFWsJ8lB5/v5cUzJwIUE9jSGws+gMHaRvvijV?=
 =?us-ascii?Q?m34sW+DPF9T2ahbMZXnIsCOP2Q5U3UaN5n5s3+NAX6aIWzKnC7Xx50UO7XaF?=
 =?us-ascii?Q?pueVG/nRAcbon1W+qiES9sBt8Ozlgf8zW6DXPj3wACGeMlUSpVsd+QqJgJeD?=
 =?us-ascii?Q?Akb2HQ7X0Lik8Rq16NhrsTC6lRjHUMcFt8s+uCUuoFjpA+C1HXYuWGwf7HYo?=
 =?us-ascii?Q?tbRkXumLOkcERIj0t2zde838T65crNEQjygNkhKijpZijZUbP5ao/entprey?=
 =?us-ascii?Q?s6EZV8dSJwO+BgzA85CvXJ+T7k7kfgC5JYiNSVi2Juj0fqgHwMW/ENsTjkLr?=
 =?us-ascii?Q?C47UW3sSKd9Qa0FYp3PUdaF2uDxivjyjAsxHdRdlKBk/n5YdY0dRJH8CaOcR?=
 =?us-ascii?Q?BWvMMjk1tiEOwDRiW0Mt6TsJ0ASsfqvRq8xGc9r0E4BJtDYQTBudtwaQXuIB?=
 =?us-ascii?Q?JTPqSf9kplJ0cPKGOTDQn1ZFZHgcEcMZbJCwJUK+b2BlIprMX68lGaXYjOZS?=
 =?us-ascii?Q?+BSzNvDf/iGBSJeJnhIQAsasZn/VCPjcY/4C+8IcfnGhtQoDgmP1VISQR43X?=
 =?us-ascii?Q?JwxLPY0DlgGpA+iDtD+5BfGs4lIDP/k+yiezBT4LIwLYLDqqIGUFS1vR3mKJ?=
 =?us-ascii?Q?IkxJNJkCJ0XNV6/BzOVQDRbctYvIwRm4nFHyOwgtH4vrpXDHCUUZTERE569m?=
 =?us-ascii?Q?GjP+XS8775E+pUL5dFNavwHdVxy/4DRfeo0J00xbFQDHvUxUJHcyKW5c2Mr8?=
 =?us-ascii?Q?oS1H1XgFWPYq1aBsvkfSfOS7CrGQ/ZDskBsUfu4V8hA5cWwCEIJWMt7Yy26J?=
 =?us-ascii?Q?z85Ecs84YSOedxZvY+ILTGLUn0/6y4Bco2rWCi2PYhFsKQfd2zR4+qxs4sLI?=
 =?us-ascii?Q?o+guDplvuJYIu8rdfr8+EN4IKLq8h0tz9ZN9Q5JPtgvVCi9Ohq3hGCTxoaah?=
 =?us-ascii?Q?FfQjeePGnBc7Ohd59QjjcPNEpbA8PuFruclM03KcoG2BnIsxWVTeZ3geVXLO?=
 =?us-ascii?Q?IogHYHDnjjL5Miqj6+okKtLnUdcv+K0lkS7C1JNNYBRP12u4F7UjqjnxiSUg?=
 =?us-ascii?Q?Q6+gDWUwGosF7qJFu4Cle4gYPubu2F0j8cZ0kzUEgdzMSgrc7UopiZ4f0vNe?=
 =?us-ascii?Q?aW1LLAFJQA0357F+OJTrnBS5i1GBU/o6EWzakDba8BF9V/NEPjw+fzTcERoF?=
 =?us-ascii?Q?0dj1DnpKWevN9IDp/ZFi1p9HC6ACBHbqe3CsqrafNBYUgtl5ufLRzjKC8qi+?=
 =?us-ascii?Q?s0dEwCyGTIy4IzU1NMpfv/eZ8R7IN8neJTCLSBTNnfzCcVJYQHyaIUBiO0//?=
 =?us-ascii?Q?5KMTDDrtYkCS6NVdmHXfW94N0LqQTHctOmlGWKHAbTEvBjPdpGRWXcmd8rYo?=
 =?us-ascii?Q?EXLrKMEKUboaqa4t8l3fztM6/41Ky/lafwEUTsaTXPO2ymfzZPji4Pchg0xT?=
 =?us-ascii?Q?R27JBh1PU/cGzhQLS+sy7+vCl1vdUf3iorMQ8dTMfETCmMca/XvLWGzBeprI?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e0dfbd-5021-4e1e-3c7c-08dc638e1642
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 12:08:29.1049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZQzfCVm24mNl8eHq64hVn5AOSUhu9ewwP1BgcfRj21UoWxikIX5lOhUbLAVpTV+FDkcA5hRaS9CTffMt+5TWkA8Rz30tvi1PN99mzvi6i4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5922

Currently, there is no way for shell scripts to safely access
resources protected by POSIX locking (fcntl with the F_SETLK/F_SETLKW
commands). For example, the glibc function lckpwdf(), used to
protect access to the /etc/shadow database, works by taking a
F_SETLKW on /etc/.pwd.lock .

Due to the odd semantics of POSIX locking (e.g. released when any file
descriptor associated to the inode is closed), we cannot usefully
directly expose the POSIX F_SETLK/F_SETLKW commands. However, linux
3.15 introduced F_OFD_SETLK[W], with semantics wrt. ownership and
release better matching those of flock(2), and crucially they do
conflict with locks obtained via F_SETLK[W]. With this, a shell script
can do

  exec 4> /etc/.pwd.lock
  flock --fcntl 4
  <access/modify /etc/shadow ...>
  flock --fcntl --unlock 4 # or just exit

without conflicting with passwd(1) or other utilities that
access/modify /etc/shadow.

No single-letter shorthand is defined for the option, because this is
somewhat low-level and the user really needs to know what he is doing.

Also, this leaves the door open for teaching --fcntl to accept an
optional argument: "ofd", the default, and "posix", should anyone find
a use for flock(1) taking a F_SETLK[W] lock.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
v2:

- Shorten option name to --fcntl instead of --fcntl-ofd.

- Use a do_lock() helper function switching on the API to use, making
  the while () condition easier to read and making it simpler to add
  the mentioned --fcntl=posix should the need arise.

- Fix up places that need HAVE_FCNTL_OFD_LOCKS guarding.

 configure.ac      |  6 ++++
 meson.build       |  3 ++
 sys-utils/flock.c | 82 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index c302732e7..441b09440 100644
--- a/configure.ac
+++ b/configure.ac
@@ -434,6 +434,12 @@ AC_CHECK_DECLS([PR_REP_CAPACITY], [], [], [
 	#include <linux/pr.h>
 ])
 
+AC_CHECK_DECL([F_OFD_SETLK],
+	[AC_DEFINE([HAVE_FCNTL_OFD_LOCKS], [1],
+	[Define to 1 if fcntl.h defines F_OFD_ constants])], [], [
+#include <fcntl.h>
+])
+
 AC_CHECK_HEADERS([security/openpam.h], [], [], [
 #ifdef HAVE_SECURITY_PAM_APPL_H
 #include <security/pam_appl.h>
diff --git a/meson.build b/meson.build
index 99126f7aa..004c849f1 100644
--- a/meson.build
+++ b/meson.build
@@ -704,6 +704,9 @@ conf.set('HAVE_DECL_BLK_ZONE_REP_CAPACITY', have ? 1 : false)
 have = cc.has_header_symbol('linux/pr.h', 'PR_REP_CAPACITY')
 conf.set('HAVE_DECL_PR_REP_CAPACITY', have ? 1 : false)
 
+have = cc.has_header_symbol('fcntl.h', 'F_OFD_SETLK', args: '-D_GNU_SOURCE')
+conf.set('HAVE_FCNTL_OFD_LOCKS', have ? 1 : false)
+
 code = '''
 #include <time.h>
 #if !@0@
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 7d878ff81..17088ce7e 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -48,6 +48,11 @@
 #include "monotonic.h"
 #include "timer.h"
 
+enum {
+	API_FLOCK,
+	API_FCNTL_OFD,
+};
+
 static void __attribute__((__noreturn__)) usage(void)
 {
 	fputs(USAGE_HEADER, stdout);
@@ -70,6 +75,9 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(  " -o, --close              close file descriptor before running command\n"), stdout);
 	fputs(_(  " -c, --command <command>  run a single command string through the shell\n"), stdout);
 	fputs(_(  " -F, --no-fork            execute command without forking\n"), stdout);
+#ifdef HAVE_FCNTL_OFD_LOCKS
+	fputs(_(  "     --fcntl              use fcntl(F_OFD_SETLK) rather than flock()\n"), stdout);
+#endif
 	fputs(_(  "     --verbose            increase verbosity\n"), stdout);
 	fputs(USAGE_SEPARATOR, stdout);
 	fprintf(stdout, USAGE_HELP_OPTIONS(26));
@@ -126,6 +134,53 @@ static void __attribute__((__noreturn__)) run_program(char **cmd_argv)
 	_exit((errno == ENOMEM) ? EX_OSERR : EX_UNAVAILABLE);
 }
 
+#ifdef HAVE_FCNTL_OFD_LOCKS
+static int flock_to_fcntl_type(int op)
+{
+	switch (op) {
+	case LOCK_EX:
+		return F_WRLCK;
+	case LOCK_SH:
+		return F_RDLCK;
+	case LOCK_UN:
+		return F_UNLCK;
+	default:
+		errx(EX_SOFTWARE, _("internal error, unknown operation %d"), op);
+	}
+}
+
+static int fcntl_lock(int fd, int op, int block)
+{
+	struct flock arg = {
+		.l_type = flock_to_fcntl_type(op),
+		.l_whence = SEEK_SET,
+		.l_start = 0,
+		.l_len = 0,
+	};
+	int cmd = (block & LOCK_NB) ? F_OFD_SETLK : F_OFD_SETLKW;
+	return fcntl(fd, cmd, &arg);
+}
+#endif
+
+static int do_lock(int api, int fd, int op, int block)
+{
+	switch (api) {
+	case API_FLOCK:
+		return flock(fd, op | block);
+#ifdef HAVE_FCNTL_OFD_LOCKS
+	case API_FCNTL_OFD:
+		return fcntl_lock(fd, op, block);
+#endif
+	/*
+	 * Should never happen, api can never have values other than
+	 * API_*, and must be API_FLOCK when !HAVE_FCNTL_OFD_LOCKS.
+	 */
+	default:
+		errx(EX_SOFTWARE, _("internal error, unknown api %d"), api);
+	}
+}
+
+
 int main(int argc, char *argv[])
 {
 	struct ul_timer timer;
@@ -140,6 +195,7 @@ int main(int argc, char *argv[])
 	int no_fork = 0;
 	int status;
 	int verbose = 0;
+	int api = API_FLOCK;
 	struct timeval time_start = { 0 }, time_done = { 0 };
 	/*
 	 * The default exit code for lock conflict or timeout
@@ -149,7 +205,8 @@ int main(int argc, char *argv[])
 	char **cmd_argv = NULL, *sh_c_argv[4];
 	const char *filename = NULL;
 	enum {
-		OPT_VERBOSE = CHAR_MAX + 1
+		OPT_VERBOSE = CHAR_MAX + 1,
+		OPT_FCNTL,
 	};
 	static const struct option long_options[] = {
 		{"shared", no_argument, NULL, 's'},
@@ -163,6 +220,9 @@ int main(int argc, char *argv[])
 		{"close", no_argument, NULL, 'o'},
 		{"no-fork", no_argument, NULL, 'F'},
 		{"verbose", no_argument, NULL, OPT_VERBOSE},
+#ifdef HAVE_FCNTL_OFD_LOCKS
+		{"fcntl", no_argument, NULL, OPT_FCNTL},
+#endif
 		{"help", no_argument, NULL, 'h'},
 		{"version", no_argument, NULL, 'V'},
 		{NULL, 0, NULL, 0}
@@ -217,6 +277,11 @@ int main(int argc, char *argv[])
 			if (conflict_exit_code < 0 || conflict_exit_code > 255)
 				errx(EX_USAGE, _("exit code out of range (expected 0 to 255)"));
 			break;
+#ifdef HAVE_FCNTL_OFD_LOCKS
+		case OPT_FCNTL:
+			api = API_FCNTL_OFD;
+			break;
+#endif
 		case OPT_VERBOSE:
 			verbose = 1;
 			break;
@@ -234,6 +299,13 @@ int main(int argc, char *argv[])
 		errx(EX_USAGE,
 			_("the --no-fork and --close options are incompatible"));
 
+	/*
+	 * For fcntl(F_OFD_SETLK), an exclusive lock requires that the
+	 * file is open for write.
+	 */
+	if (api != API_FLOCK && type == LOCK_EX)
+		open_flags = O_WRONLY;
+
 	if (argc > optind + 1) {
 		/* Run command */
 		if (!strcmp(argv[optind + 1], "-c") ||
@@ -280,9 +352,15 @@ int main(int argc, char *argv[])
 
 	if (verbose)
 		gettime_monotonic(&time_start);
-	while (flock(fd, type | block)) {
+	while (do_lock(api, fd, type, block)) {
 		switch (errno) {
 		case EWOULDBLOCK:
+			/*
+			 * Per the man page, for fcntl(), EACCES may
+			 * be returned and means the same as
+			 * EAGAIN/EWOULDBLOCK.
+			 */
+		case EACCES:
 			/* -n option set and failed to lock. */
 			if (verbose)
 				warnx(_("failed to get lock"));
-- 
2.40.1.1.g1c60b9335d

