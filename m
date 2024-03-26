Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8122112D772
	for <util-linux@vger.kernel.org>; Tue, 26 Mar 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468215; cv=none; b=fPJoPHiKlfBwAKRDfq724b0LFKEwXRj/Zz5LIErRjX12r2MwnEfz2YdcNlcDqOzVgxYUSvYnVwRqVQ3Gg8ymDCxdQIRxpAViEyfrmPoy6llwHP/VFtP1VOuz4yFrxNRig6hgaaLNKyBaQ+LTg5zQGJTjx9beFVc8kPDI9vAkcyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468215; c=relaxed/simple;
	bh=eB0sb54oLBAUPTGK5BSb091gP1dR1GTtdJJah1ab6Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uboWAByj0K/5rTIUs0ZKUEJJTVv+BY5yOma3mko7yzDSnK2OO5j1avjw7NJb99zMAOVs9O3RxqcRyUTYmdo7yamFNbhNx+WmFLCNyhjAkhUjX5JrQRFG17PInvsNyCtIv0B/c6iLn8dUGqoBl1Xjog0TgLhZDjgp1EcEuOs5fUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=RcYt4y+L; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="RcYt4y+L"
X-KPN-MessageId: 5c58edbb-eb88-11ee-bbc8-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5c58edbb-eb88-11ee-bbc8-005056abad63;
	Tue, 26 Mar 2024 16:48:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=i1IbjtQ3YdTf92j4FGVliSOVMFkbFoZq7UV7KsHfHj8=;
	b=RcYt4y+LjZ41dgD9OqGMw8RZSawvn7QuY99gBmQjNAxCYIWvkCzENiz9nAAUfR0AGN6ev86ztWjQx
	 V+XiVvNVu33DPb8zsX0XfuEu19LiaZrOycNW0scUMuUEryXG329tXW1YkNPoq/xVqijGc/zGepiqvI
	 HPCOTlb+qegApouI=
X-KPN-MID: 33|VPy/v2rEMPjSxtoX+ruqyFvsE/T4us4ITkjcAOwE9Pyd7OYEk9mGIqL5cV5lqO1
 8WnnKDsJV81YUg0mclvIYCgDW4Y7qqfLP+poUhfEyHEI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|86wB3WJBhTQzFktJs3ImZOkGcf1ZGti5kK+9GH5La/BbyD1zB8hsflz4Lo7oeew
 AYL+2j9d2xellY+JtlQES7A==
Received: from localhost (82-168-50-91.fixed.kpn.net [82.168.50.91])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 5e6544c9-eb88-11ee-a20e-005056ab1411;
	Tue, 26 Mar 2024 16:49:02 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Petr Pisar <petr.pisar@atlas.cz>
Subject: [PATCH 1/2] textual: fix some typos and inconsistencies in usage and error messages
Date: Tue, 26 Mar 2024 16:48:21 +0100
Message-ID: <20240326154822.8959-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported-by: Petr Pisar <petr.pisar@atlas.cz>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 login-utils/lslogins.c | 2 +-
 misc-utils/lastlog2.c  | 2 +-
 misc-utils/lsfd.c      | 2 +-
 misc-utils/lslocks.c   | 2 +-
 misc-utils/waitpid.c   | 2 +-
 sys-utils/irqtop.c     | 4 ++--
 sys-utils/setpriv.c    | 2 +-
 term-utils/agetty.c    | 4 ++--
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index c6958a464..d13d3d720 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1527,7 +1527,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("     --notruncate         don't truncate output\n"), out);
 	fputs(_(" -o, --output[=<list>]    define the columns to output\n"), out);
 	fputs(_("     --output-all         output all columns\n"), out);
-	fputs(_(" -p, --pwd                display information related to login by password.\n"), out);
+	fputs(_(" -p, --pwd                display information related to login by password\n"), out);
 	fputs(_(" -r, --raw                display in raw mode\n"), out);
 	fputs(_(" -s, --system-accs        display system accounts\n"), out);
 	fputs(_("     --time-format=<type> display dates in short, full or iso format\n"), out);
diff --git a/misc-utils/lastlog2.c b/misc-utils/lastlog2.c
index 4029f5e48..2b8365b40 100644
--- a/misc-utils/lastlog2.c
+++ b/misc-utils/lastlog2.c
@@ -114,7 +114,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -i, --import FILE       Import data from old lastlog file\n"), output);
 	fputs(_(" -r, --rename NEWNAME    Rename existing user to NEWNAME (requires -u)\n"), output);
 	fputs(_(" -s, --service           Display PAM service\n"), output);
-	fputs(_(" -S, --set               ySet lastlog record to current time (requires -u)\n"), output);
+	fputs(_(" -S, --set               Set lastlog record to current time (requires -u)\n"), output);
 	fputs(_(" -t, --time DAYS         Print only lastlog records more recent than DAYS\n"), output);
 	fputs(_(" -u, --user LOGIN        Print lastlog record of the specified LOGIN\n"), output);
 
diff --git a/misc-utils/lsfd.c b/misc-utils/lsfd.c
index d4d2a99bc..41d0dd282 100644
--- a/misc-utils/lsfd.c
+++ b/misc-utils/lsfd.c
@@ -422,7 +422,7 @@ static const struct colinfo infos[] = {
 				   N_("user of the process") },
 	[COL_XMODE]            = { "XMODE",
 				   0,   SCOLS_FL_RIGHT, SCOLS_JSON_STRING,
-				   N_("extended version of MDOE (rwxD[Ll]m)") },
+				   N_("extended version of MODE (rwxD[Ll]m)") },
 };
 
 static const int default_columns[] = {
diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index 3d70b047f..946f724e6 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -89,7 +89,7 @@ static struct colinfo infos[] = {
 	[COL_END]  = { "END",    10, SCOLS_FL_RIGHT, N_("ending offset of the lock")},
 	[COL_PATH] = { "PATH",    0, SCOLS_FL_TRUNC, N_("path of the locked file")},
 	[COL_BLOCKER] = { "BLOCKER", 0, SCOLS_FL_RIGHT, N_("PID of the process blocking the lock") },
-	[COL_HOLDERS] = { "HOLDERS", 0, SCOLS_FL_WRAP, N_("HOLDERS of the lock") },
+	[COL_HOLDERS] = { "HOLDERS", 0, SCOLS_FL_WRAP, N_("holders of the lock") },
 };
 
 static int columns[ARRAY_SIZE(infos) * 2];
diff --git a/misc-utils/waitpid.c b/misc-utils/waitpid.c
index 0a4e03d16..4d77e1df4 100644
--- a/misc-utils/waitpid.c
+++ b/misc-utils/waitpid.c
@@ -236,7 +236,7 @@ int main(int argc, char **argv)
 
 	if (count && count > n_pids)
 		errx(EXIT_FAILURE,
-		     _("can't want for %zu of %zu PIDs"), count, n_pids);
+		     _("can't wait for %zu of %zu PIDs"), count, n_pids);
 
 	pid_t *pids = parse_pids(argc - pid_idx, argv + pid_idx);
 
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 7baa47baf..11a11fb50 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -177,7 +177,7 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
 	efd = epoll_create1(0);
 
 	if ((tfd = timerfd_create(CLOCK_MONOTONIC, 0)) < 0)
-		err(EXIT_FAILURE, _("cannot not create timerfd"));
+		err(EXIT_FAILURE, _("cannot create timerfd"));
 	if (timerfd_settime(tfd, 0, &ctl->timer, NULL) != 0)
 		err(EXIT_FAILURE, _("cannot set timerfd"));
 
@@ -197,7 +197,7 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
 	sigaddset(&sigmask, SIGQUIT);
 
 	if ((sfd = signalfd(-1, &sigmask, SFD_CLOEXEC)) < 0)
-		err(EXIT_FAILURE, _("cannot not create signalfd"));
+		err(EXIT_FAILURE, _("cannot create signalfd"));
 
 	ev.events = EPOLLIN;
 	ev.data.fd = sfd;
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 890fa2427..4b0543101 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -135,7 +135,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --bounding-set <caps>       set capability bounding set\n"), out);
 	fputs(_(" --ruid <uid|user>           set real uid\n"), out);
 	fputs(_(" --euid <uid|user>           set effective uid\n"), out);
-	fputs(_(" --rgid <gid|user>           set real gid\n"), out);
+	fputs(_(" --rgid <gid|group>          set real gid\n"), out);
 	fputs(_(" --egid <gid|group>          set effective gid\n"), out);
 	fputs(_(" --reuid <uid|user>          set real and effective uid\n"), out);
 	fputs(_(" --regid <gid|group>         set real and effective gid\n"), out);
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 0fc6f1514..4532e7454 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -2463,12 +2463,12 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -H, --host <hostname>      specify login host\n"), out);
 	fputs(_(" -i, --noissue              do not display issue file\n"), out);
 	fputs(_(" -I, --init-string <string> set init string\n"), out);
-	fputs(_(" -J  --noclear              do not clear the screen before prompt\n"), out);
+	fputs(_(" -J, --noclear              do not clear the screen before prompt\n"), out);
 	fputs(_(" -l, --login-program <file> specify login program\n"), out);
 	fputs(_(" -L, --local-line[=<mode>]  control the local line flag\n"), out);
 	fputs(_(" -m, --extract-baud         extract baud rate during connect\n"), out);
 	fputs(_(" -n, --skip-login           do not prompt for login\n"), out);
-	fputs(_(" -N  --nonewline            do not print a newline before issue\n"), out);
+	fputs(_(" -N, --nonewline            do not print a newline before issue\n"), out);
 	fputs(_(" -o, --login-options <opts> options that are passed to login\n"), out);
 	fputs(_(" -p, --login-pause          wait for any key before the login\n"), out);
 	fputs(_(" -r, --chroot <dir>         change root to the directory\n"), out);
-- 
2.42.1

