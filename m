Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6823213280F
	for <util-linux@vger.kernel.org>; Wed, 17 Apr 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348607; cv=fail; b=tLqQFQif++LcJay4qoEYaQSyCCIJ4rHfSgf8So1SYeT7mHE1NUzEDkEfCP/x+DgwmeNvfnUC0BGGwiUuW3r+fgRggf5eJe4SNJJks1G6EXSb5CGsgiSfTIlF2BgnizX6xNgb6nu7jQ7Z50JB8v9+19gaMyqJBfFFFEQW1NwlCVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348607; c=relaxed/simple;
	bh=n7TY5GnAdiNuhoSD2aLlqs7zjMT6q3acNSP+5bIePFU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=e/UkKHc1RzFSZbnPTM7tlwQ39UN9vaJBqO4vxgTKLwKavlOw8SpDRAmh9isZ3IWLufOXomzB1brdESKgWZiyZWfxK5eNS4xmnqK3HqxgkySkVXCXAbQhgpiX77zkGjmzu9+eUCqNiLNNBCtPzRC1LVcg8zyxszsVQfdUdip6VfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=REiHS1TV; arc=fail smtp.client-ip=40.107.8.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="REiHS1TV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjwzkaBXyWoNf2jtRRF6Qpn41E1cFT8MziqjcRkSv96wyVnP8WYUHAUG2MG/vknMF781To6CBs/bFzwIFeEyhmMlR/GkPSYenwOZuoHix2wm7JO1Hf7fwgQavhGINx+IkI8IbtMQBV7lkpElHiwGXVrjDCehrYgSG8QVwct8UVG0CClRZ6Tb8YufR2j5zXnxaynlZvJ+Obj76+wex8xZdyrJgkB8bWxgZhTVDa5zCsJtjTGfTZq0UA+FmqGbnzgQqklr+N+VzUkwfVPm/sau0aYpqdXL2OVoiPYaZpSM0RBZD46H2qEdULFM4gmAiJN1P+6DH1kZEWwP+OkRWjojfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rs/RObaMpZTp9Px9HFyqcs1DipG66J2pZu08KUZACak=;
 b=SrWqggjyUlFyiyX9iOHRtvu/qDlSj6tt9ljCpy5wOqAdyjS86XcqAibGOyzLKhmuMlZ5liCexTtkZDVbRVXdr7f1SBsFGuNQek0G/Nz2liTTiPX4NSQxv0hf2t+fkcxvvzaMlsRJda7he2THzlD2qQ8thpyev43WjC1+XOBjVmqiBm6/hVDDP3Zimi9ilNLuKqWpucAFSjZlDgsh6ZTaJj6kSN1igUn4Q7Nq+PNhqU3QB0HWCIP7vDk/xEFvwiXGNXNUcaYHW1nTYIBHv6aiQD9ATwdCQqMxa251xsJtd7VFROWZSfO5lVmDY0dOi5pyNj60JBZEjLLSyAY8JhF3MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rs/RObaMpZTp9Px9HFyqcs1DipG66J2pZu08KUZACak=;
 b=REiHS1TVWA7RyUHLSm58oddT34lNYSnp+OtzFYUMIdjCY8tz6hPzYYXTW2S++cTQDsCLyqYtik3rkjRLvlEMd1sxCME3wsV+kVLN2yGfFA6AHQHg6H3hQ16UXYwnIxYkihwXJpgi8XbxLA1o8jnDzzdIV+ggQYfMtaQNHKYq9cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PA4PR10MB5707.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:266::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 10:09:58 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3704:5975:fae0:7809%6]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 10:09:58 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] flock: add support for using fcntl() with open file description locks
Date: Wed, 17 Apr 2024 12:09:48 +0200
Message-Id: <20240417100948.75817-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::19) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PA4PR10MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f5f22c-0e8f-449e-5ee8-08dc5ec68962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YOqGFKS/g0P+8vXZDUlxp+J/Ot7OC/sFU4sl6JcnNycC/lWO5vamSCEcO+aUTE+YU0xvxjex39EchjSx6VD2V2hJ6HDkXJxX3kz+FWI8Ipk+PEzO6eQ90vnaQRnWohk+phy4zsxNUby1zNuqFoo+fRPlcK4S7htHZco/CgoX5r3yTfKFTjDmyhwcEFLuHhlJHqfr8vDdZcuUaT7p3bOmpq0RDSAvRNAYNwneXXMwoMNhPQV+P7A1Q7nUVoT9pKnUAjP7bcN64oxT9OrEFxj9N1xmzc0u4AIvb5hNI901FtiA7QAIGVJht3DZ34NkXZt+r8DOF5B7IwGipfdpf3R2NR/HH4ZcAAKnVLGbHMmZPumhRdh7kmE1WH6wIm6as98L+hvcKaI+/lQs08ol7NyAL4+9Oi+s3gEqLqJdgI0h2DJh+puJW0/2oyLq6t0/YayVPFDT+1QHq0oZPcM6yjEmBmXoKPxA28AmpVyuVZrI3cOh+U7c4YZktyFdFjFqruQXpFgFfmdP/15G61JDwBGttWRgrKQttjF//dPX3MaL8Y8iX+50gzTo+SX+e+TIp10XjeKHczCOPRluxuH8IOWFVgKKXKcWtEKePVtQgQT2x6ChRp9GO52EPq7wsiXSoZf1S84gSaEV97mCFQ58ZxyD3u3a0BbxIP/4bPDGK+Yz3nrzk8fmkgzsyWkwDvlCTkVV+B+sXHE3m3ceEdHpomCNug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OmKAcZuOimHak1Z6Vw5DL6+DBc5A9tXYh6JNzDA+dz2x62qK/paYoXVvtbNo?=
 =?us-ascii?Q?sDyag+LH6SoUeXmvSRmXN55W91vWMGXvLlnvb72gxNvouhQgHB96pY9fhj9U?=
 =?us-ascii?Q?ebaJS8TkKr9YlF7sXhX23DTP1OwomgQ86NBG2PZDRvBgLXh/U1kAgSrnEmYz?=
 =?us-ascii?Q?lHzHfGpd6uB6mV6v1i7kM+uYHxsAIFdX0HcII9KSfPWs3R41/DPnzNGAgXjX?=
 =?us-ascii?Q?ig2u7aspkxtesBwIgWcbDC+/FqbPcp+OpMAXmeq049lV0NDkiiG32Xr6K3hY?=
 =?us-ascii?Q?SM7Pp9x5/rWQoi3bN4MqLu3XBa6PNlO+s2OYbXXA4xbRu0lnt8fn9y8rmmDn?=
 =?us-ascii?Q?xHApmLD6VZocAcSJcufyC2Gm+w0/QptR1cXyzUPK/E/ae37NNSK3aipQRi8W?=
 =?us-ascii?Q?IeOhY886e/+x5pUxM2+ACnd1UKelF1gyY6kBnhY37SYoqFuKxTIshRHJxnrw?=
 =?us-ascii?Q?v+49AJkTTif0VZMw79Xa4obohutDxpL+09iG+ycr9rOyi+x/d3cweAQgV2mb?=
 =?us-ascii?Q?ihDmKsdEhzb6eBoPdwcT+zTlHGk2GNthSKHKeSTGyAwYccdjDDWCPXHqP3Me?=
 =?us-ascii?Q?At1ey0Emsi5XzQCViMFOVP+EdLWb2cEEtVOmzZtob2SMZCcNRhn+9U5U/cw8?=
 =?us-ascii?Q?e+4/dHe1n0emf3q8vuNkr2pghhXHB5+hKEE6ufYCapFtUMxkjcaO+vmMbmop?=
 =?us-ascii?Q?Ow2NeG/jemruzAPzTwRXlVwOtZCbTinxbUADgA4rDpYfvVu3CtwPVU5p3l3P?=
 =?us-ascii?Q?pUiXGsOnLS2Wvt5mzzADukv0yjDlUn1yqG47hruP09hkHEwWEGbn8C3p//Iz?=
 =?us-ascii?Q?UyM3pjv8UWVAvJW1ZYOPnl4eHq+JuSo0PY9eM/pmg+3jn79395uXV7NaulPF?=
 =?us-ascii?Q?29m71B+Ly0jRVZNlhfEUtTCl3S1/Z5w/rMAUZH2YTrME9hU1H+26vWTyrQeM?=
 =?us-ascii?Q?wi/8KJv2Y7Setioox4h6Pg66baUyVJAcKk15pK3ueXXExPB1F4iEjbaXHZtb?=
 =?us-ascii?Q?rJPioVrXRhK8oKEAVmO07a5uW5k0O3sXANYlVA1RAu2rM3Ob/QCpm4MeYTL+?=
 =?us-ascii?Q?cDz1SstynK+AcrImxONyB4YLvX5cs+3cBswF3Z2vLPxguq7A/7GeBaoEjzUP?=
 =?us-ascii?Q?p+gXG+hXnao3TbPzCgVNX8/Qw967p7po5MT66JhqO93lPUDtNfCl6lTLRC5k?=
 =?us-ascii?Q?30nu8QlT3O1wKO8jZ6dfsFqVBHVWyvjnyU9PTDYwvVujLC5TVyyXwm8q7DmP?=
 =?us-ascii?Q?kxDpeJdqD4PcYvzp5bNgUxc0CRHMlbqBfROK6dt6yyEJf9tNfcYcYXkKQ7Ho?=
 =?us-ascii?Q?ojr5d0/CAATQA3jbE0o7KUr7t2FyLGknzoKyeG58JktEpdVzcCuhOLzxuWD9?=
 =?us-ascii?Q?QSd+q2TLBhn1qCZXX8HO88bsgacB/Zd7JvNp3DcyRBQtVPUFG7XWyhN2jvbv?=
 =?us-ascii?Q?RVL/g93l53PODNoMGxFyrYgYpKnc8++XEFfNwB9mT31MxdduMdrwRbkwUn4J?=
 =?us-ascii?Q?xP8A0QXeCbejF969hx+g0/G0jEowLzpIjUbXEpvgqAnXsUpIpfVWniarTv09?=
 =?us-ascii?Q?iOiD9fx6ayLo/2VzLVjtEwGvcbSKyFxSdOOhxDkXnHk1T7MpqZDWZus59win?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f5f22c-0e8f-449e-5ee8-08dc5ec68962
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 10:09:58.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa57Mmkd3HkpeUvROYVXvWCC+JITAZYc882bGsd/EHG3xPmCWPfHs3U8yZQBRt9CJQnuhjQVeCCtPWya1YxCaDBCliJa0qpyWzVkrqYjaY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5707

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
  flock --fcntl-ofd 4
  <access/modify /etc/shadow ...>
  flock --fcntl-ofd --unlock 4 # or just exit

without conflicting with passwd(1) or other utilities that
access/modify /etc/shadow.

The option name is a bit verbose, and no single-letter shorthand is
defined, because this is somewhat low-level and the user really needs
to know what he is doing.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

---

Both my autotools and meson fu are weak to non-existing, so I don't
know if I've written the "test if the header exposes this macro"
correctly.

I'm not at all married to the option name. I also considered just
making it --fcntl, with the possiblity of making that grow an optional
argument (for example --fcntl=posix with plain --fcntl being an alias
for --fcntl=ofd) should anyone ever figure out a use for the plain
F_SETLK, perhaps just for testing.


 configure.ac      |  6 +++++
 meson.build       |  3 +++
 sys-utils/flock.c | 60 +++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 67 insertions(+), 2 deletions(-)

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
index 7d878ff81..40751517d 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -70,6 +70,9 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(  " -o, --close              close file descriptor before running command\n"), stdout);
 	fputs(_(  " -c, --command <command>  run a single command string through the shell\n"), stdout);
 	fputs(_(  " -F, --no-fork            execute command without forking\n"), stdout);
+#ifdef HAVE_FCNTL_OFD_LOCKS
+	fputs(_(  "     --fcntl-ofd          use fcntl(F_OFD_SETLK) rather than flock()\n"), stdout);
+#endif
 	fputs(_(  "     --verbose            increase verbosity\n"), stdout);
 	fputs(USAGE_SEPARATOR, stdout);
 	fprintf(stdout, USAGE_HELP_OPTIONS(26));
@@ -126,6 +129,38 @@ static void __attribute__((__noreturn__)) run_program(char **cmd_argv)
 	_exit((errno == ENOMEM) ? EX_OSERR : EX_UNAVAILABLE);
 }
 
+static int flock_to_fcntl_type(int op)
+{
+        switch (op) {
+                case LOCK_EX:
+                        return F_WRLCK;
+                case LOCK_SH:
+                        return F_RDLCK;
+                case LOCK_UN:
+                        return F_UNLCK;
+                default:
+			errx(EX_SOFTWARE, _("internal error, unknown operation %d"), op);
+        }
+}
+
+static int do_fcntl_lock(int fd, int op, int block)
+{
+#ifdef HAVE_FCNTL_OFD_LOCKS
+	struct flock arg = {
+		.l_type = flock_to_fcntl_type(op),
+		.l_whence = SEEK_SET,
+		.l_start = 0,
+		.l_len = 0,
+	};
+	int cmd = (block == LOCK_NB) ? F_OFD_SETLK : F_OFD_SETLKW;
+	return fcntl(fd, cmd, &arg);
+#else
+	/* Should never happen, nothing can ever set use_fcntl_ofd when !HAVE_FCNTL_OFD_LOCKS. */
+	errno = ENOSYS;
+	return -1;
+#endif
+}
+
 int main(int argc, char *argv[])
 {
 	struct ul_timer timer;
@@ -140,6 +175,7 @@ int main(int argc, char *argv[])
 	int no_fork = 0;
 	int status;
 	int verbose = 0;
+	int use_fcntl_ofd = 0;
 	struct timeval time_start = { 0 }, time_done = { 0 };
 	/*
 	 * The default exit code for lock conflict or timeout
@@ -149,7 +185,8 @@ int main(int argc, char *argv[])
 	char **cmd_argv = NULL, *sh_c_argv[4];
 	const char *filename = NULL;
 	enum {
-		OPT_VERBOSE = CHAR_MAX + 1
+		OPT_VERBOSE = CHAR_MAX + 1,
+		OPT_FCNTL_OFD,
 	};
 	static const struct option long_options[] = {
 		{"shared", no_argument, NULL, 's'},
@@ -163,6 +200,7 @@ int main(int argc, char *argv[])
 		{"close", no_argument, NULL, 'o'},
 		{"no-fork", no_argument, NULL, 'F'},
 		{"verbose", no_argument, NULL, OPT_VERBOSE},
+		{"fcntl-ofd", no_argument, NULL, OPT_FCNTL_OFD},
 		{"help", no_argument, NULL, 'h'},
 		{"version", no_argument, NULL, 'V'},
 		{NULL, 0, NULL, 0}
@@ -217,6 +255,11 @@ int main(int argc, char *argv[])
 			if (conflict_exit_code < 0 || conflict_exit_code > 255)
 				errx(EX_USAGE, _("exit code out of range (expected 0 to 255)"));
 			break;
+#ifdef HAVE_FCNTL_OFD_LOCKS
+		case OPT_FCNTL_OFD:
+			use_fcntl_ofd = 1;
+			break;
+#endif
 		case OPT_VERBOSE:
 			verbose = 1;
 			break;
@@ -234,6 +277,13 @@ int main(int argc, char *argv[])
 		errx(EX_USAGE,
 			_("the --no-fork and --close options are incompatible"));
 
+	/*
+	 * For fcntl(F_OFD_SETLK), an exclusive lock requires that the
+	 * file is open for write.
+	 */
+	if (use_fcntl_ofd && type == LOCK_EX)
+		open_flags = O_WRONLY;
+
 	if (argc > optind + 1) {
 		/* Run command */
 		if (!strcmp(argv[optind + 1], "-c") ||
@@ -280,9 +330,15 @@ int main(int argc, char *argv[])
 
 	if (verbose)
 		gettime_monotonic(&time_start);
-	while (flock(fd, type | block)) {
+	while (use_fcntl_ofd ? do_fcntl_lock(fd, type, block) : flock(fd, type | block)) {
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

