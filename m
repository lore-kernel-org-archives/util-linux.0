Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0851C84AF
	for <util-linux@vger.kernel.org>; Sat, 15 Feb 2025 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636357; cv=none; b=KknfBXvtWvq/IZNwGR/VSQFsZd+C++3zm5x1x4Eb5pfyZUzQNiwQBKlOX+qPkPbd6M71opk6XlmtRA/LRM+UfWgr4ChJY3qOuPNrVdOoNMSnrtIJd8IbNtLmbwyaZeHifq9tRQLtS4IB+bJqVNjOFLBXgQL/K9/sT4fZlfgrFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636357; c=relaxed/simple;
	bh=yTko41+uCZggf/iOk7hYmIiXOduaCz5XKW+pntkCmUo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jT0JOCKXJYZ0tWvVqhzQXMsQpjWdOod/rylz6wsSt8/royQeyiOryJs3tDv+EWxyII/VkOR5DjSU8J98IZoGHHsnuOOXHMdapYKn2RQLQN7+XVnx8MOeYvz1iERkO3EpbzvJZJJLrCss2cYYh6UaCL2ysTA3b0U+tTfETgUPJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=atcjWDjn; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="atcjWDjn"
X-KPN-MessageId: 94cce13b-ebb8-11ef-99cf-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 94cce13b-ebb8-11ef-99cf-005056abbe64;
	Sat, 15 Feb 2025 17:19:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=zP1cV61Ps8oo18MYsyHXtBZ+5JJug5iQpz4u8q6/lS4=;
	b=atcjWDjnCSA71F5WrEAuhG1arxs0YL/ABNWIMjJAaVDvmy4//TKAkxLQWuhQgdqKnp/YxYaKYfOBw
	 NBRdpXcRSNya6IveyUwZ6QRPyc05L81P80sO2UFKkq2YzI7u6bzvpzNdZS+h7TZOKhoppFPL0z1yeB
	 LpF2/7kuvQ6q2sqo=
X-KPN-MID: 33|LSpCzIurzl+iZYjnlFY+36CSq03gSmXx+z/zgeVkHE2kVNM19kmDrKqPAcdiyON
 3po632RcQw3zoHkHyId3W3ZBasf1ylEW1gNlE5eKYdsU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|f9hAGoYxRzzia76/RMuctZseYzqhWxoVWvPY4ksXmcXYEysejtme8qYHBCzMbQg
 oEJIe0NOf1cgXwxEeowa7kQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 94cf13ac-ebb8-11ef-be91-005056ab7584;
	Sat, 15 Feb 2025 17:19:07 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/10] setterm: put an option and its description in a single message
Date: Sat, 15 Feb 2025 17:18:35 +0100
Message-ID: <20250215161843.12053-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215161843.12053-1-bensberg@telfort.nl>
References: <20250215161843.12053-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And improve a bit of markup and a wording in the man page.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 term-utils/setterm.1.adoc | 4 ++--
 term-utils/setterm.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/term-utils/setterm.1.adoc b/term-utils/setterm.1.adoc
index 38dc81ab5..3fdee3283 100644
--- a/term-utils/setterm.1.adoc
+++ b/term-utils/setterm.1.adoc
@@ -115,14 +115,14 @@ Sets the VESA powerdown interval in minutes. Without an argument, it defaults to
 *--powersave* _mode_::
 Valid values for _mode_ are:
 
-*vsync|on*;;
+*vsync*|*on*;;
 Puts the monitor into VESA vsync suspend mode.
 *hsync*;;
 Puts the monitor into VESA hsync suspend mode.
 *powerdown*;;
 Puts the monitor into VESA powerdown mode.
 *off*;;
-Turns monitor VESA powersaving features.
+Turns the monitor's powersaving features off.
 
 *--regtabs*[**=**1-160]::
 Clears all tab stops, then sets a regular tab stop pattern, with one tab every specified number of positions. Without an argument, it defaults to *8*. Virtual consoles only.
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 53bc6785d..801095c87 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -430,8 +430,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --file <filename>             name of the dump file\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 
-	fputs(_(" --powersave on|vsync|hsync|powerdown|off\n"), out);
-	fputs(_("                               set vesa powersaving features\n"), out);
+	fputs(_(" --powersave on|vsync|hsync|powerdown|off\n"
+	        "                               set vesa powersaving features\n"), out);
 	fputs(_(" --powerdown[=<0-60>]          set vesa powerdown interval in minutes\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 
-- 
2.48.1

