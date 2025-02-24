Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DFB23373E
	for <util-linux@vger.kernel.org>; Mon, 24 Feb 2025 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402611; cv=none; b=AsjhTA5Afib/q5MDxd3PE2y930FILbjrCXvzOp4/0I0pvwTDJBnxGhyMNM+TK/I4Fayrt39SR+sTbD+7rYuyrgV55u4mM0YmjB6F9jQG/rhvB2BgNozeauxg2yK0T/GOXv+1atL14z9t4EGJ3VDOrpZW6wsL8Xex1/6BzLNURMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402611; c=relaxed/simple;
	bh=UZUoxOqk6Ns7taJwRwWTaxLdyG1Lb5TLQjulgYoDiG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwEe4nHMK/63ik9RPVzFsUQuHxAFBhk3sOCCfSKlOoSs3ug5CSvuuwVzRmQpGAu9zXm7sld/q+JXjlcyF1dGFVFEAltfeqVD6vl0xyKFZg3x0Yryy2xMlaetpd7mOYAWGUdBOK2oTcBj0k/cgeSJO9HlMWw+Iigacp8GRGCr99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=GDn4vGco; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="GDn4vGco"
X-KPN-MessageId: 8a3821b1-f2b0-11ef-86c8-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8a3821b1-f2b0-11ef-86c8-005056aba152;
	Mon, 24 Feb 2025 14:09:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=o9fcnirN7C1YviVtuZohLqH9C3403cqlNKVS7L0bTkk=;
	b=GDn4vGcop810wk0J+5UH2ngZwVOU4l5N9NbrH+7rv9YnB7ooM7T64e+DU7bmN7sOPl4BM0Knfwii4
	 dOPuSP7PIEUAlbQ1bAZA3psMw9M1BgI9PYAxNMg59KPbhlpt4Z/4LzF0Ea15Ep2E/ttrK1HusGZFgX
	 OgpcaO3O+39gMvBg=
X-KPN-MID: 33|KOhL3lwN0nU1B91k3vHuqTl4LmvcFUYHYaDONfbPPCoAqTDGUDeG/hVDCN1vPlc
 x/wGlfZYWkh5/6K8DECuivM1nWsOZtA1KhFIg+obRfRA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|rKDOZsx6kuob0wGHaqd5i8yzqN03K/FIR6HfgS+0MiY/vhPmIMMXRdLDr/xh6LJ
 0gs25rZ8E2cMVMINqOR80tA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 83bb2da9-f2b0-11ef-849d-005056ab7584;
	Mon, 24 Feb 2025 14:09:01 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Jonathan Ketchker <jonathan@ketchker.com>
Subject: [PATCH 2/6] scriptreplay: make Up/Down keys use a percentage instead of fixed amount
Date: Mon, 24 Feb 2025 14:08:36 +0100
Message-ID: <20250224130840.25770-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224130840.25770-1-bensberg@telfort.nl>
References: <20250224130840.25770-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using a fixed 0.1 amount made each subsequent Down-arrow key slow things
down _more_, and each subsequent Up-arrow key speed things up _less_.
It's nicer when each subsequent keystroke has the same relative effect.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 term-utils/scriptreplay.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index 0e1444ca1..5751e1b52 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -76,8 +76,8 @@ usage(void)
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Key bindings:\n"), out);
 	fputs(_(" space        toggles between pause and play\n"), out);
-	fputs(_(" up-arrow     increases the time divisor with 0.1\n"), out);
-	fputs(_(" down-arrow   decreases the time divisor with 0.1\n"), out);
+	fputs(_(" up-arrow     increases playback speed with ten percent\n"), out);
+	fputs(_(" down-arrow   decreases playback speed with ten percent\n"), out);
 
 	fprintf(out, USAGE_MAN_TAIL("scriptreplay(1)"));
 	exit(EXIT_SUCCESS);
@@ -343,10 +343,10 @@ main(int argc, char *argv[])
 			if (ch == '[') {
 				ch = fgetc(stdin);
 				if (ch == 'A') { /* Up arrow */
-					divi += 0.1;
+					divi *= 1.1;
 					replay_set_delay_div(setup, divi);
 				} else if (ch == 'B') { /* Down arrow */
-					divi -= 0.1;
+					divi *= 0.9;
 					if (divi < 0.1)
 						divi = 0.1;
 					replay_set_delay_div(setup, divi);
-- 
2.48.1

