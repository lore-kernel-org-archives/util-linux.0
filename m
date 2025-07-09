Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46C274B33
	for <util-linux@vger.kernel.org>; Wed,  9 Jul 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052077; cv=none; b=RLKzlr2DNXmsBrUgH+BT/GzsCNDR70QiZOs0Sur0wv1ZIyiGfe4s968PAdpAiei6xAhI3IYsny67GqPjntEwii/wXudOvvRC5PLmoJzX97SwbETdXk6lrK7R68PU9ZnMalSkshYOMC3bysjbY4foeyYnHAsS7ssK4GNWtRVxY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052077; c=relaxed/simple;
	bh=yGugUtqEah7TafxWtOZ97XIPC0EdceC7jky5E4gchvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgC5IL0JoA3BX19dEjNZMGhs9Cs7EXN+IjstbmfOo3/mCzvR2kiwCMsL1/NrRG4cSiQqb/NVvMuGry/wXVdg7h9jWOuqWxkH5exCtKTufSx5hc1Bo8NZ4WadJr6158fdxnYJv8SZMRKt5JH89Wu4UWL6ufPstThwbb0G98tEwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=CQKHfMJa; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="CQKHfMJa"
X-KPN-MessageId: 64883549-5ca4-11f0-bc2f-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 64883549-5ca4-11f0-bc2f-005056ab378f;
	Wed, 09 Jul 2025 11:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=E+t74bW61knzMPYUQYBF09oT6kPqREad4Vq5fiWN3KQ=;
	b=CQKHfMJape9ToI5h0IWx3JLJpbisSRGpEd9cM1dhimdHZDb4jgcbFj5ZA7aXL5IYPzZOfsdcGO/uj
	 qAEDl705U5wkpRtWuENzaQ9WUqaKcTShjgoemA+8VQGZ6PLtofUpMtNWduaOXxU14VWbtonPc2XMxl
	 svhJ0bsIUhJiemN4=
X-KPN-MID: 33|ajDUHiIPANP4EFlwzieVWk4pJZd2q0s0YmhuqNtAzfSnGl6HAN7HeELYGLIDqjj
 vsEkgaAj4BffLWDMT8a9ECCMlSmV+6UewrRGZLDVfLYM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|xp9lzGQmOrCsCBI+qsvhaXsVYg53Kbz2igGgczVBPsIxXeRVolv1rOWDr6aIcWC
 aLvGCfinnbR4pxg1GbCqhVQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 3205a113-5ca4-11f0-9c51-005056ab1411;
	Wed, 09 Jul 2025 11:07:53 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] textual: harmonize the messages for invalid count and timeout values
Date: Wed,  9 Jul 2025 11:07:34 +0200
Message-ID: <20250709090734.18263-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.2
In-Reply-To: <20250709090734.18263-1-bensberg@telfort.nl>
References: <20250709090734.18263-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 login-utils/sulogin.c | 2 +-
 misc-utils/findmnt.c  | 2 +-
 misc-utils/uuidgen.c  | 2 +-
 misc-utils/waitpid.c  | 5 ++---
 sys-utils/flock.c     | 3 +--
 sys-utils/wdctl.c     | 4 ++--
 term-utils/agetty.c   | 2 +-
 term-utils/wall.c     | 4 ++--
 8 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 0de850508..eb4609db6 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -1037,7 +1037,7 @@ int main(int argc, char **argv)
 	while ((c = getopt_long(argc, argv, "ehpt:V", longopts, NULL)) != -1) {
 		switch(c) {
 		case 't':
-			timeout = strtou32_or_err(optarg, _("invalid timeout argument"));
+			timeout = strtou32_or_err(optarg, _("invalid timeout"));
 			break;
 		case 'p':
 			profile = 1;
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index ee9371e69..31350df78 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1998,7 +1998,7 @@ int main(int argc, char *argv[])
 			findmnt.flags |= FL_UNIQ;
 			break;
 		case 'w':
-			timeout = strtos32_or_err(optarg, _("invalid timeout argument"));
+			timeout = strtos32_or_err(optarg, _("invalid timeout"));
 			break;
 		case 'x':
 			verify = 1;
diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 6133cb0eb..8e07cdb65 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -147,7 +147,7 @@ main (int argc, char *argv[])
 			do_type = UUID_TYPE_DCE_MD5;
 			break;
 		case 'C':
-			count = strtou32_or_err(optarg, _("invalid count argument"));
+			count = strtou32_or_err(optarg, _("invalid count"));
 			break;
 		case 's':
 			do_type = UUID_TYPE_DCE_SHA1;
diff --git a/misc-utils/waitpid.c b/misc-utils/waitpid.c
index f108206a9..b63532790 100644
--- a/misc-utils/waitpid.c
+++ b/misc-utils/waitpid.c
@@ -197,14 +197,13 @@ static int parse_options(int argc, char **argv)
 			verbose = true;
 			break;
 		case 't':
-			strtotimespec_or_err(optarg, &timeout,
-					     _("Could not parse timeout"));
+			strtotimespec_or_err(optarg, &timeout,  _("invalid timeout"));
 			break;
 		case 'e':
 			allow_exited = true;
 			break;
 		case 'c':
-			count = str2num_or_err(optarg, 10, _("Invalid count"),
+			count = str2num_or_err(optarg, 10, _("invalid count"),
 					       1, INT64_MAX);
 			break;
 		case 'V':
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 6e58a1d51..fe1a71f72 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -273,8 +273,7 @@ int main(int argc, char *argv[])
 			break;
 		case 'w':
 			have_timeout = 1;
-			strtotimeval_or_err(optarg, &timeout.it_value,
-				_("invalid timeout value"));
+			strtotimeval_or_err(optarg, &timeout.it_value, _("invalid timeout"));
 			break;
 		case 'E':
 			conflict_exit_code = strtos32_or_err(optarg,
diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index b3203d461..f3ae0e3f8 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -792,11 +792,11 @@ int main(int argc, char *argv[])
 				return EXIT_FAILURE;
 			break;
 		case 's':
-			ctl.timeout = strtos32_or_err(optarg, _("invalid timeout argument"));
+			ctl.timeout = strtos32_or_err(optarg, _("invalid timeout"));
 			ctl.set_timeout = 1;
 			break;
 		case 'p':
-			ctl.pretimeout = strtos32_or_err(optarg, _("invalid pretimeout argument"));
+			ctl.pretimeout = strtos32_or_err(optarg, _("invalid pretimeout"));
 			ctl.set_pretimeout = 1;
 			break;
 		case 'f':
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index f65e511ca..5e564c4f0 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -852,7 +852,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 			op->flags |= F_KEEPSPEED;
 			break;
 		case 't':
-			op->timeout = strtou32_or_err(optarg,  _("invalid timeout argument"));
+			op->timeout = strtou32_or_err(optarg,  _("invalid timeout"));
 			break;
 		case 'U':
 			op->flags |= F_LCUC;
diff --git a/term-utils/wall.c b/term-utils/wall.c
index 293275cb3..1152a1222 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -240,9 +240,9 @@ int main(int argc, char **argv)
 				warnx(_("--nobanner is available only for root"));
 			break;
 		case 't':
-			timeout = strtou32_or_err(optarg, _("invalid timeout argument"));
+			timeout = strtou32_or_err(optarg, _("invalid timeout"));
 			if (timeout < 1)
-				errx(EXIT_FAILURE, _("invalid timeout argument: %s"), optarg);
+				errx(EXIT_FAILURE, _("invalid timeout: %s"), optarg);
 			break;
 		case 'g':
 			group_buf = init_group_workspace(optarg);
-- 
2.48.2

