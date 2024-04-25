Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEBA84FAB
	for <util-linux@vger.kernel.org>; Thu, 25 Apr 2024 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038277; cv=fail; b=FTdqu2hZO5Mvfa03flVgVrZF9fvKz69/hGdyOGMaw6q33BBhDZjT8vnvnLqRVDTih/Qkr6cyT51IUGOuG8702aVTwvXbQUsu85/Ip5tKZGqwa+P3UFBi0Y9WfE8RvDynId00sg3cWa6fHcHS4RPe8mXgQVuIh5YI1BcUnwsFmIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038277; c=relaxed/simple;
	bh=cfAvwpxhM866uJDxz4B9Q91tgGf+OLxXuHERt9Q7Tq8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oiMpzjfkgAQx8C8clSs2aqJMqbnTG+neUk216LfDd83yknw0hH94yocTBf3B65IZw1/hXtjv6bJZyedvs5g2EGXRG1Wbi9cWuN7PeF+xDWRzZEBZ/5HncdEhQzNKyh3aih7Qc2yeY8nPiYH4BgkQVDpwCsqW0QDXUikyortGq1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=SjRCFmmh; arc=fail smtp.client-ip=40.107.22.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="SjRCFmmh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ue31gfAgt/jhQhSqbuhuwrIKI1mdf9XNWnDF+Fc8d8iKOxFuBBgWDQ2H04AxhmLRDIvfgCkHPP2oddnB7XiVjXTPm5LsYKINvB/NybwSrAn8MAb7yxBIfOx6d77bEVcfDKQJ3klbR8bWPf3GenGMOONrV+yBYu3VfPvw45ETkobQYuCsXUnot57vH06YsTxSRAGv7EXDaQVN7leEBmBo7OFy8mdHb2AP5qjB+9J6Xz84971vdDOLcnXPD/pmKV0kE6hRn1syMLj8TdfH1sIK18009NEwjcICuNGG8i/y8h+x6c0ziut4085c4hfMOI01OFFkbbs3r/Q8MiFQM5JGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5jL616MCKAZF3Rr+ZGFy16wkd97+jB2Sdztu8Zh5b4=;
 b=h+7aZQFCWXJoOwDC7Ky5x7OFKia8rW5bF1osFwqKYgBho3Ab8736qGQJJWfX/L2ol5RdyFfjH5AxXAz6afV1t3xjxGFfuaAsOH3OL50TDABBgJeXpuZhIWn4COxBFb95CYwL/eJ8hftpMDQYGlFH2QGmnSQfo7iZG+zao7Zb2fIEGzkJsNC0e3cO41Urhh7b77TUw1yK2EVldhDEDAkfppnUvVff0HAGhMvH9G2fbMaPx437PXW92OFgk4uLYOLmz0YCDujVZGn6B0PKqcz+7sa5xSawnpuwm8uxXxnsItu6ZnyMTXcbAxsGk8Kh34MwRauSF/GAHrFp60hoKfib6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5jL616MCKAZF3Rr+ZGFy16wkd97+jB2Sdztu8Zh5b4=;
 b=SjRCFmmhrbnS+awVTU5PKGdnzIH3ZbXK4R45Bnk5dcZJRQ+AzC4MN/SCtJ2y2EhZLbwK2Mxa7L41VatzRS7hhbiWaie/XrJhdTnxqkwBa+x+yGmga8sKh6N+OIJ2LGIHxQBnHYIGOkb4sgWG86DgVcoPcAq4+tmxq08nuhgXrQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PR3PR10MB3962.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 09:44:28 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dd6e:5f37:1abc:9119]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dd6e:5f37:1abc:9119%6]) with mapi id 15.20.7472.045; Thu, 25 Apr 2024
 09:44:28 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: util-linux@vger.kernel.org
Cc: Masatake YAMATO <yamato@redhat.com>,
	Karel Zak <kzak@redhat.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v3] flock: add support for using fcntl() with open file description locks
Date: Thu, 25 Apr 2024 11:44:17 +0200
Message-Id: <20240425094417.1174162-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0022.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::7)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PR3PR10MB3962:EE_
X-MS-Office365-Filtering-Correlation-Id: 88dea244-dac1-419b-4ee4-08dc650c4c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ZquhfZiwc8NnGeNSTiH18UjxCO+9I41gQPYqNK3Mtoj1LmNHOIaAsdIVMEZ?=
 =?us-ascii?Q?1Y7d2d+9ZUoyXlJEEKSwChJbq2HyPVqhcbr0ILB1oeHsez/EhpBNK5Ecg34M?=
 =?us-ascii?Q?u7ATlXXWtbVnOLH07d0kiC0oCHV7ZrTqfOvppAT0N/YWCn/yx3JeVvGr0yQk?=
 =?us-ascii?Q?aBo7O/8OnriHKpPLwkoQ9mAugEpcP9FEobRGzG7VelChode7Pm/yPAQoCBfD?=
 =?us-ascii?Q?qjKd88fAw1NMFoeJNpayzRhMpd8LE+WiOoKrhbPV51nM8CqnfS/mnl2R4pLZ?=
 =?us-ascii?Q?iaR3xJHWGhletKXtR7dFhK76JNhKnHTINXgtLVXvJW9hEOu46ZVDxc6aHgdw?=
 =?us-ascii?Q?9yEvIsvG6wij7TehKfwouuIrgHUj1J5OxBDrbMSYBKHGgjl2EVXEXiI33ZY7?=
 =?us-ascii?Q?QF50Niyti2K+r5e7Zw9KXHncB/fxzub4iBzNYEzTXk2r//RScrYdffkUS7zs?=
 =?us-ascii?Q?tL3nEbvvNO4kgFOIuk6YZq8zJPieN9alrQHZcKqfoMB+1hPcW1xoENy+3CNm?=
 =?us-ascii?Q?G+mbvNtBWvlx1IM+kObUwoK1XQ8iwFHa6uFBq4Ijohc3TRwUNrq7iFaXCU2E?=
 =?us-ascii?Q?WiD7pBNkeaYoASvRbzIwURTam9hG/n+Z177qWDkkiHoPlid7UW8b73irXnJA?=
 =?us-ascii?Q?eD4o0jE3Td4pmmd60tsTysX7bm/viOBr0DbIOgc6UKOg6e+/bVY//o0GOko5?=
 =?us-ascii?Q?xMz1/gyA7GK6hQydGBGuoMkhjKqsVgjRDT8U4n3mBovl4YC7UKdeaP1BO19S?=
 =?us-ascii?Q?V8x3W5cwFVrGVxMggDPrqZ3Q106nkQEPdczI6ZxARZEjgm0yMjrQjDfGT3NS?=
 =?us-ascii?Q?c5oVA3V6HOQwK+1EaX/T4l0wqoIOcZfpMsj1/8i6UDQNix2zr/S83k6QYfWp?=
 =?us-ascii?Q?cwyxtGBzK2V9POiEc0LeYvlZ+PiCPA08Cwo4zwSGwvWgxG+1kfR62z0w6Ds1?=
 =?us-ascii?Q?eO+8YvUoLpRV0QgAtHrcz5h3Od4cUkwI4u98x2rHGBr/MYt1CyWEd+faSpcv?=
 =?us-ascii?Q?aOYM4NTq1QqWaJKdXhFFY4MHS6zKUi8gCYaSRbLdchFLsJJN3VmqAnygXz/i?=
 =?us-ascii?Q?crGi4tCxg4sl0t8VlegTwPJxKBK/OpUxknX/eG2eerpU9yoWU1V6+k3oINuB?=
 =?us-ascii?Q?OGYk8E1+BfovGSEeapfdWaPvmTjWschn5Bgk8VSHvy6nlpVcKkjY9M9zFHYo?=
 =?us-ascii?Q?rmgytMGXIkhLHUkpq4i68bTdvRfLBk3HbOqJdwy3sIwCU65yxyfRZPyMPU30?=
 =?us-ascii?Q?E5bvFd1F30jIdjSapoT1IPSsY0/jlXGR+YF5gwZLxQ20DgE6jM5IxxuCaEj2?=
 =?us-ascii?Q?pzqfJItjnB5Wnn5lKAiIxZn190AAQznh5x2yTNG/+R4Fsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wTXFjxQXs/RTRtkTimA+VO6xLEDL8WefWAUP07QYE9TCV/QpQTJA++Ik3YJg?=
 =?us-ascii?Q?Wr2wdWpQjF43//ogRquSrGrCt1qNM62pBHEGcVXJQ5taR7CdhLsKOmetv5d1?=
 =?us-ascii?Q?pn0lC+uXHAhcZUYiid/X0ra0k1d5dlRvJS7ya8ByHtew2zW9+AX6CrZiM5Ca?=
 =?us-ascii?Q?GOyWHNJOLlS5NfYmEIETyrxW0M7Ohb5SZp/tCPpvm5entyNyUy0mcOPGBQ7c?=
 =?us-ascii?Q?P/6ZgyTueN5BHjZMINSVM2BBzxMgxPdSwZJpDwYJplFNHqCRsB3RiL1nRglO?=
 =?us-ascii?Q?OOIk0IwddvqOjpIdtToTBKqBTMrY1KQs7jPDLjwPNc/hqQPzcIKOaUxKZ3uN?=
 =?us-ascii?Q?fCMGqmCh8Jyc7wlxKnNtOn4T89Castr5fLdFoJW6uqcDtFYQZPG6VADqEGgi?=
 =?us-ascii?Q?NqCTPY7FRxrKA3NQGmvGBGr0jfsWdLVX6o0IwxhtEF445lpnWkCYRG0n+ftS?=
 =?us-ascii?Q?03VFdimaczR7/Q22HpAv4JfNi7FbkCq+iWSuxVrMjvYazTJhh6wpeZSdm2PP?=
 =?us-ascii?Q?NcDDfPax5mStotzWcstnejyGyMCQtFYxSKQ+BW6h0AOo8nnqL+yYb68KbaLW?=
 =?us-ascii?Q?hXKOxZZVxz3cjPC5lgJovgN/1gHJwsKNLoltJg3yfb4dBzqoQXdn+Ly8o63G?=
 =?us-ascii?Q?af12uppNub4o2wh2DOqo4m2C+TC4ha3aN5obuegHD7uTaRKlGgGXViStgz28?=
 =?us-ascii?Q?r2+V0nUszylxfWNqUl61mMzJ9qxy1DoFNH1dKhMF+qutVNr9WJh9cpzFSOCc?=
 =?us-ascii?Q?COdrvxK9aQ9PidIzJBFZf7rmT5qORXTVLvakf39IaNsP9UxSNSUVo/ZrCCYZ?=
 =?us-ascii?Q?BqQ88ochW3QyoUZcAc2V4hvZITjWTIYmndvJC6sVwBEDbg38krEi+5x7I+AJ?=
 =?us-ascii?Q?x6+3/UXby6rOzpE60iR85u95kwu/jAY2wDRtaDLGuHY/AKCzUYmLlG/kgf7a?=
 =?us-ascii?Q?0UgZVW1EbtkcT4qm+OfuTbzp77zfwv5Ysi+APovDTOopnvTdWxmr07vJXoXq?=
 =?us-ascii?Q?d2Tb/fWOa7lWj2olMJreNB2zimM5EPgx3Y3aAqRJsDWRR2C1+qWN274ZB9/O?=
 =?us-ascii?Q?GWEVH5FG/dbjYJkTgKNuC43Hjp/hGq9HyWVTy1++/vbgseN5pzb4YJs3hZhp?=
 =?us-ascii?Q?F/UrY7LslaDAqF9eoJKICpYAZhPydq0wPtcL82OxIGCiYVBGvlnPErNzl/HT?=
 =?us-ascii?Q?5AnRA1bQdoVRgXYfzK6GvyvXJ23Nk4EMMLGs2quJskLhYkCSeaGw8IX3FoEo?=
 =?us-ascii?Q?emHX3aHJpCHDS/2WJ//bm7NqDekc5+WuzJkpJPuSC17yogMevknNbeqvmzGg?=
 =?us-ascii?Q?jfx4Z4J5q65Ebwp12koNu5pEd4/G37CnKrBIJmjN5nN7gqLqDSyfIATTfR9m?=
 =?us-ascii?Q?BYkcwnFdOEM/gCv0Q3DOO+r/TCJMs96LUX+FaW+TE2bq5FNEwdhD+Erfy5bv?=
 =?us-ascii?Q?uaVX0gpAsvREkKgeqA/WwfyzgoLvHkP3XhiolfYLJ96LbekJJPjS9KvT6i2L?=
 =?us-ascii?Q?8O/Qo5nQgeqIckmcMwiOjiyOtqRvFQ2DEoB3N+0X67apa4e2KhkXO3VT2XDT?=
 =?us-ascii?Q?BElOiZsuOC/0fCiAYx/CKV8xAS/jdTUMi8akg6GNRzHrm7usOmsJA0jFP61E?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dea244-dac1-419b-4ee4-08dc650c4c8b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:44:28.0380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OdCwi4CtCbwIj6u4Q2QfnfczXVm33vodUAZxHJBM1mZNdPs+aTwB9+lNUc4kQpXbdp7lObAqk/UFDKiZD+saoQCn+Vbq30Vf2bmEItkFEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3962

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
v3:

- Replace configure-time checking for F_OFD_ by just hard-coding the
  proper values in flock.c if the system headers don't provide them.

- Consequently, drop all HAVE_FCNTL_OFD_LOCKS guards.

v2:

- Shorten option name to --fcntl instead of --fcntl-ofd.

- Use a do_lock() helper function switching on the API to use, making
  the while () condition easier to read and making it simpler to add
  the mentioned --fcntl=posix should the need arise.

- Fix up places that need HAVE_FCNTL_OFD_LOCKS guarding.

 sys-utils/flock.c | 78 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 7d878ff81..c42c9da51 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -48,6 +48,17 @@
 #include "monotonic.h"
 #include "timer.h"
 
+#ifndef F_OFD_GETLK
+#define F_OFD_GETLK	36
+#define F_OFD_SETLK	37
+#define F_OFD_SETLKW	38
+#endif
+
+enum {
+	API_FLOCK,
+	API_FCNTL_OFD,
+};
+
 static void __attribute__((__noreturn__)) usage(void)
 {
 	fputs(USAGE_HEADER, stdout);
@@ -70,6 +81,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(  " -o, --close              close file descriptor before running command\n"), stdout);
 	fputs(_(  " -c, --command <command>  run a single command string through the shell\n"), stdout);
 	fputs(_(  " -F, --no-fork            execute command without forking\n"), stdout);
+	fputs(_(  "     --fcntl              use fcntl(F_OFD_SETLK) rather than flock()\n"), stdout);
 	fputs(_(  "     --verbose            increase verbosity\n"), stdout);
 	fputs(USAGE_SEPARATOR, stdout);
 	fprintf(stdout, USAGE_HELP_OPTIONS(26));
@@ -126,6 +138,49 @@ static void __attribute__((__noreturn__)) run_program(char **cmd_argv)
 	_exit((errno == ENOMEM) ? EX_OSERR : EX_UNAVAILABLE);
 }
 
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
+
+static int do_lock(int api, int fd, int op, int block)
+{
+	switch (api) {
+	case API_FLOCK:
+		return flock(fd, op | block);
+	case API_FCNTL_OFD:
+		return fcntl_lock(fd, op, block);
+	/*
+	 * Should never happen, api can never have values other than
+	 * API_*.
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
@@ -163,6 +220,7 @@ int main(int argc, char *argv[])
 		{"close", no_argument, NULL, 'o'},
 		{"no-fork", no_argument, NULL, 'F'},
 		{"verbose", no_argument, NULL, OPT_VERBOSE},
+		{"fcntl", no_argument, NULL, OPT_FCNTL},
 		{"help", no_argument, NULL, 'h'},
 		{"version", no_argument, NULL, 'V'},
 		{NULL, 0, NULL, 0}
@@ -217,6 +275,9 @@ int main(int argc, char *argv[])
 			if (conflict_exit_code < 0 || conflict_exit_code > 255)
 				errx(EX_USAGE, _("exit code out of range (expected 0 to 255)"));
 			break;
+		case OPT_FCNTL:
+			api = API_FCNTL_OFD;
+			break;
 		case OPT_VERBOSE:
 			verbose = 1;
 			break;
@@ -234,6 +295,13 @@ int main(int argc, char *argv[])
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
@@ -280,9 +348,15 @@ int main(int argc, char *argv[])
 
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

