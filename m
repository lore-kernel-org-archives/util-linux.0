Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5176F9FE
	for <util-linux@vger.kernel.org>; Mon, 14 Apr 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623994; cv=none; b=HMOcSCthkm0TXXncEK9FA5L+1MGehr628T8x3VgMPe4+3njpLVoH4nr4nZlQ3UEB7GBkHOZPdn2Cd298zTdt8nFR1aI+Cq3YwDwQqyswziYyY4EtACyiELxC4ULgz8Ob77xQcbCIw21zGRmysvda7Cf+GmcjQqg8Up5s/NThhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623994; c=relaxed/simple;
	bh=NNV77CLhWGCyJ+d/+YdgA9Lihv5TOYFNEVrO1TX+4kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngje5GW8HJFeBn72Wd5suCBN+k/fckhNxf+dXndrFxnAfA6pp7buPGtfBf1Jc+looX1lRrYX8JPv/eTYE/iC+TeIPpdohZ+BzJVkawWQ5o2bJ/zZ4qgK24cjjjhFCbeCNOIZjU/YZ7G8E04UZRFiBT3pJVWOKDahaNfX5oYiATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=eSpjSQn6; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="eSpjSQn6"
X-KPN-MessageId: 637fc209-1915-11f0-a82e-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 637fc209-1915-11f0-a82e-005056abad63;
	Mon, 14 Apr 2025 11:46:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=wpbBq/u/a9cvh+i+J9eOi7VZeE/aw5U7Xcfe2glWmu4=;
	b=eSpjSQn66ax3Y4Yv1Qm1yURfeO0dpjCLwH0Qk0Ly8zfHSO0xez0kLWthh+obg0NSXd9i0pO4RMO4l
	 jNZ7mMfgWBWwGpUvsCRUUM5Up/3k0UYA6qhyiX0BfCVpX1kJ2J7elSGTe1bflfvoKxLQfDrRcIDRNO
	 7HvLf68jd9O8UcSk=
X-KPN-MID: 33|0Nd6cfPid96vAD1vDU6FhFOE/QBUx6IxrTk2DCNfDpsmiIdESexLjdx3laynBfj
 xrHNmngTVnONPlNtCOMoi1y2Ag8lbEU17DzjuyHSMTu0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|sp+0esWJJCR2zaJAcDQkhYTP0EsaMLY+O+U0Rm5IqV8GIUwVk0e9bGyM1Qo5dwr
 zakao8UM1i8x9BfpeQqh00Q==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 571e6821-1915-11f0-9bf3-005056ab7447;
	Mon, 14 Apr 2025 11:46:29 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Stefan Schubert <schubi@suse.de>
Subject: [PATCH 7/8] lastlog2: (man) fix some broken markup, and lowercase option arguments
Date: Mon, 14 Apr 2025 11:45:33 +0200
Message-ID: <20250414094534.9504-7-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250414094534.9504-1-bensberg@telfort.nl>
References: <20250414094534.9504-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, reshuffle two paragraphs (from the end to the beginning), reword
some things, and remove the mistaken _num_ argument of --service.

Furthermore, use triple pluses to tell asciidoctor that two asterisks
in a message are literal asterisks and not markup: +++**+++.

CC: Stefan Schubert <schubi@suse.de>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/lastlog2.8.adoc | 68 +++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/misc-utils/lastlog2.8.adoc b/misc-utils/lastlog2.8.adoc
index fb0cf52c9..e14e6b9cc 100644
--- a/misc-utils/lastlog2.8.adoc
+++ b/misc-utils/lastlog2.8.adoc
@@ -20,49 +20,55 @@ lastlog2 - displays date of last login for all users or a specific one
 
 == DESCRIPTION
 
-
-*lastlog2* displays the content of the last login database. The _login-name_,
+*lastlog2* displays the content of the last-login database. The _login-name_,
 _last-login-time_, _tty_ and _remote-host_ will be printed.
-The default (no flags) causes all last login entries to be printed, sorted
-by the order as written the first time into the database.
+By default (no flags) all last-login entries are printed,
+in the order they were first written into the database.
 
-Compared to *lastlog* this command is Y2038 safe and uses sqlite3 to store the
-information and not a sparse file.
+If a user has never logged in, the message *+++**+++Never logged in+++**+++*
+is displayed in the last-login-time column.
+
+Only the entries for the current users of the system are displayed.
+Other entries may exist for users that have meanwhile been deleted.
+
+Compared to *lastlog*(8), this command is Y2038-safe, and uses SQLite3
+instead of a sparse file to store the information.
 
 == OPTIONS
 
 *-a*, *--active*::
-Print last login records excluding users who have never logged in.
+Do not print entries for users who have never logged in.
 
-*-b*, *--before* _DAYS_::
-Print only last login records older than _DAYS_.
+*-b*, *--before* _days_::
+Print only the last-login records older than _days_.
 
 *-C*, *--clear*::
-Clear last login record of a user. This option can be used only together with
-*-u' (*--user*).
-
-*-d*, *--database _FILE_::
-Use _FILE_ as lastlog2 database.
-
-*-i*, *--import* _FILE_::
-Import data from old lastlog file _FILE_. Existing entries in the lastlog2
-database will be overwritten.
-
-*-r*, *--rename* _NEWNAME_::
+Clear the last-login record of a user.
 This option can only be used together with *-u* (*--user*).
 
-*-s*, *--service* _num_::
-Display PAM service used to login in the last column.
+*-d*, *--database* _file_::
+Use _file_ as lastlog2 database.
+
+*-i*, *--import* _file_::
+Import data from an old lastlog file named _file_.
+Existing entries in the lastlog2 database will be overwritten.
+
+*-r*, *--rename* _newname_::
+Rename the user given with *-u* to this _newname_.
+This option can only be used together with *-u* (*--user*).
+
+*-s*, *--service*::
+Display the PAM service used to login in the last column.
 
 *-S*, *--set*::
-Set last login record of a user to the current time. This option can only be used
-together with *-u* (*--user*).
+Set the last-login record of a user to the current time.
+This option can only be used together with *-u* (*--user*).
 
-*-t*, *--time* _DAYS_::
-Print only last login records more recent than _DAYS_.
+*-t*, *--time* _days_::
+Print only last-login records more recent than _days_.
 
-*-u*, *--users* _LOGINS_::
-Print only the last login record of the user _LOGIN_.
+*-u*, *--user* _login_::
+Print (or modify) the last-login record of the user _login_.
 
 *-h*, *--help*::
 Display help text and exit.
@@ -70,12 +76,6 @@ Display help text and exit.
 *-v*, *--version*::
 Display version and exit.
 
-If the user has never logged in the message **Never logged in** will be displayed
-in the latest login time row.
-
-Only the entries for the current users of the system will be displayed.
-Other entries may exist for users that were deleted previously.
-
 == FILES
 
 */var/lib/lastlog/lastlog2.db*::
-- 
2.48.1

