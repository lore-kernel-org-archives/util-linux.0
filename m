Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8C1FBCB0
	for <util-linux@vger.kernel.org>; Mon,  7 Apr 2025 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038938; cv=none; b=GrPk+UAMp96wJ+PWQNYZkmKuvjBqWvY7ETL512levQTSydo6b0IMTxBLqdVGpnRYtNKqyX46yoz+X/n6uHTn65AnTqhPwVKnUgg44yLkGkikdAC7kCPmzLXCqBlRCjfXkxnsI+EYbBwaFos0Je6bEkZbZ0sXlNi0GO1/V/9DabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038938; c=relaxed/simple;
	bh=neSZTo+lVWCwbAfhAia11Df6pkeurh+sIL+z3wkOHd8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvQN1tEh1IWGcYk037sLc4jraIPNDAR6o+K3ERw1j32qEm6hnrfUFEBb1udAFH3OHm/r6cCHMtiYcWUZjGSnzLhuD6d4BMmBLlbP+v98JHPmbY+j8hwMnG9JKIcYTRfird8NKnJH1E0ceypJvIj8Yrkx2R57Lm5+P3F7JsoGdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=B9jvMIsi; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="B9jvMIsi"
X-KPN-MessageId: 3497e662-13c3-11f0-a82d-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3497e662-13c3-11f0-a82d-005056abad63;
	Mon, 07 Apr 2025 17:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=5c7wwAA6GtixFDi+26yjIH5h5MNkSgvczN8fjZD55S4=;
	b=B9jvMIsiDKFFeJiF7MXQEGezYthH10TRE54C6eYICr+5L8dGWZ4QqnkxmUVEgABfmg4P/yfIOwOPu
	 Jb3OuMD6oBCarB0fjm6koeGSu4H7BaJf6m8YOxZvKlo1GojxSrSccZ14bwdqw4jXxzvnZuUS+Po0cl
	 HiBr6KJswYBr/K4o=
X-KPN-MID: 33|LqZAQcFOXm4yoCf22jLMCDfbExWUG3YwytoDiw5VdTAzK30gI/Zv+Jv/xIZW2N0
 tL9LnuRmbzz3rOP4hwM7TIHCPl2e7QExFyUkne4WiCDo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|h59CJhN9plxls2MB8t44Vi1HsT1hVRAJ25oY3uGk+9Z0Y3Q5jqDXbVG0ZW1MBpz
 5wISlLp2XIiF4bLE7wz57ag==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 264742e2-13c3-11f0-9599-005056abf0db;
	Mon, 07 Apr 2025 17:15:33 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/8] blkzone: (man) reduce two overblown tables to legible proportions
Date: Mon,  7 Apr 2025 17:14:35 +0200
Message-ID: <20250407151503.23394-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407151503.23394-1-bensberg@telfort.nl>
References: <20250407151503.23394-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Before version 2.37, before asciidoctor was used, the first three lines
of the first table looked like this:

       start     Zone start sector
       len       Zone length in number of sectors
       wptr      Zone write pointer position

After the move to asciidoctor, the first three lines of the first table
in the generated man page looked like this:

       ┌────────┬────────────────────────────┐
       │        │                            │
       │start   │ Zone start sector          │
       ├────────┼────────────────────────────┤
       │        │                            │
       │len     │ Zone length in number of   │
       │        │ sectors                    │
       ├────────┼────────────────────────────┤
       │        │                            │
       │wptr    │ Zone write pointer         │
       │        │ position                   │
       ├────────┼────────────────────────────┤

Three to four screen lines for just one line of information!

Reduce the tables to sane proportions again by simply using blocks
of preformatted text.

(The substition of xN for x? is needed because somehow the ? in the
indented text is a special character in groff.)

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/blkzone.8.adoc | 44 +++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/sys-utils/blkzone.8.adoc b/sys-utils/blkzone.8.adoc
index 8456b5e42..ac5413ed0 100644
--- a/sys-utils/blkzone.8.adoc
+++ b/sys-utils/blkzone.8.adoc
@@ -29,31 +29,29 @@ The command *blkzone report* is used to report device zone information.
 By default, the command will report all zones from the start of the block device. Options may be used to modify this behavior, changing the starting zone or the size of the report, as explained below.
 
 Report output:
-[cols=",",]
-|===
-|start |Zone start sector
-|len |Zone length in number of sectors
-|cap |Zone capacity in number of sectors
-|wptr |Zone write pointer position
-|reset |Reset write pointer recommended
-|non-seq |Non-sequential write resources active
-|cond |Zone condition
-|type |Zone type
-|===
+....
+ start      Zone start sector
+ len        Zone length in number of sectors
+ cap        Zone capacity in number of sectors
+ wptr       Zone write pointer position
+ reset      Reset write pointer recommended
+ non-seq    Non-sequential write resources active
+ cond       Zone condition
+ type       Zone type
+....
 
 Zone conditions:
-[cols=",",]
-|===
-|cl |Closed
-|nw |Not write pointer
-|em |Empty
-|fu |Full
-|oe |Explicitly opened
-|oi |Implicitly opened
-|ol |Offline
-|ro |Read only
-|x? |Reserved conditions (should not be reported)
-|===
+....
+ cl    Closed
+ nw    Not write pointer
+ em    Empty
+ fu    Full
+ oe    Explicitly opened
+ oi    Implicitly opened
+ ol    Offline
+ ro    Read only
+ xN    Reserved conditions (should not be reported)
+....
 
 === capacity
 
-- 
2.48.1

