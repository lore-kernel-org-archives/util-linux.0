Received: from csmtpq2-prd-nl1-vfz.edge.unified.services (csmtpq2-prd-nl1-vfz.edge.unified.services [84.116.50.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1283191DA
	for <util-linux@vger.kernel.org>; Wed,  3 Dec 2025 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.116.50.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789976; cv=none; b=bW6VeNQQuPfNfCbRiVteCPhsO1jxBgS3lrc7EwyaqdGg4q7lWIkUBMXNjazsrDp22r1xZMX7LiTsAtxwEcy7nmsXUmRchXvVUusV3sJZvzUVEwUljnWvnF1zwy/UX6WJa3o2teYmjtoebV7IGG0O6XSODI+jrwm48RZrt1C3Dk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789976; c=relaxed/simple;
	bh=n5E2sMaPF1G9wZwxFj9lr9vzYXgavfnhIk3jtOivyOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0CMwt28Uo8ok2UlYhI7Rdz8U1qR77vwA6UK+6HuApdo3ARPm7vvgb9RiKAOR/n04frSTNh/hcw8/JCn2AX3vhZVi6vJm+9NZqAPMGG/zZCAyxUKu9X1riOis915tUQwhbdNqaAPJXXmWVlwrq75OuSJ7h84QeDkIMVP9FCAfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl; spf=none smtp.mailfrom=mrns.nl; dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b=FlgLGO8u; arc=none smtp.client-ip=84.116.50.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mrns.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b="FlgLGO8u"
Received: from csmtp5-prd-nl1-vfz.nl1.unified.services ([100.107.80.45] helo=csmtp5-prd-nl1-vfz.edge.unified.services)
	by csmtpq2-prd-nl1-vfz.edge.unified.services with esmtp (Exim 4.95)
	(envelope-from <dick@mrns.nl>)
	id 1vQsUN-009Lc7-L2
	for util-linux@vger.kernel.org;
	Wed, 03 Dec 2025 20:26:11 +0100
Received: from routi.mrns.nl ([212.204.155.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by csmtp5-prd-nl1-vfz.edge.unified.services with ESMTPSA
	id QsUMvS0oxJKSGQsUMvQTKQ; Wed, 03 Dec 2025 20:26:11 +0100
X-Env-Mailfrom: dick@mrns.nl
X-Env-Rcptto: util-linux@vger.kernel.org
X-SourceIP: 212.204.155.133
X-CNFS-Analysis: v=2.4 cv=M7rn7Sws c=1 sm=1 tr=0 ts=69308ed3 cx=a_exe
 a=+NQzl7YsTyKB6E3DpOjMZQ==:117 a=+NQzl7YsTyKB6E3DpOjMZQ==:17
 a=wP3pNCr1ah4A:10 a=LQrtYbNyCH8A:10 a=4425vRj2VURtf0qpTaoA:9
X-Authenticated-Sender: ieb1yoh3@ziggo.nl
Received: by routi.mrns.nl (sSMTP sendmail emulation); Wed, 03 Dec 2025 20:26:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrns.nl;
 i=@mrns.nl; q=dns/txt; s=mail; t=1764789970; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding : from;
 bh=n5E2sMaPF1G9wZwxFj9lr9vzYXgavfnhIk3jtOivyOQ=;
 b=FlgLGO8uqkNNnmENudLDj+4EYja7QOOX2zX4WoYXHFJtnSfN1OM5gKNnhFmR6FahUqlna
 E7n29yPAYKVNxTbaAZ5lQNd1217WKHSeWgR2lK5W5zbUUlXzT8Tf4RlN8ghGbOsZ/1Eob5c
 17Gln0BUzRlwh7LHxkBYHIRIucKTDNI=
From: Dick Marinus <dick@mrns.nl>
To: util-linux@vger.kernel.org
Cc: Dick Marinus <dick@mrns.nl>
Subject: [PATCH 0/1] copyfilerange: new command to call copy-file-range
Date: Wed,  3 Dec 2025 20:25:48 +0100
Message-ID: <20251203192558.1116470-1-dick@mrns.nl>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251202201500.1029349-1-dick@mrns.nl>
References: <20251202201500.1029349-1-dick@mrns.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfF5Xef+YJKtSltSwJaD3yRlACMBtkblZ3a0g6/xsCzMsCf3N4JP3o2xtTT70pQJkQTFXUrEn67Uc/D3MOAvRZJJeX8pxW2PJVytUtoJvodkYwOPwZlq8
 VN/ZSTEzlLV0gXtN1oDqz43xAHbzq+JuQrqTXsiR4Z09U3iYMRvdcO0+i/u3BBupKTBcyMZ5sjSZxIxqh/gjT9A98kXfzFW9o9M=

Hello!

Sorry for the repost, I noticed my previous mail wasn't properly signed
and was probably blocked as spam.

I finally finished my work on a command to create reflinked files. Since
my last post on this mailing list I found the copy_file_range system
call and I named this command after it.

I decided to contribute this command first, when this is done I will
post another command to find duplicate blocks in two files, which can
serve as input of this command.

This command should be usable for other use cases as well, it's also
possible to create sparse files and it can be used instead of how many
people use dd if= of= skip= count=

I tried to implement everything in a similar way as used by the other
sources in this project (and I learned a lot from it).

Nothing is set in stone although I want to keep to the Unix philosophy
and not any wild features to this command.

Please let me know what can (or must) be added or improved.

Dick Marinus (1):
  copyfilerange: new command to call copy-file-range

 .gitignore                                 |   1 +
 configure.ac                               |   3 +
 meson.build                                |  14 ++
 meson_options.txt                          |   2 +
 misc-utils/Makemodule.am                   |   9 +
 misc-utils/copyfilerange.1.adoc            |  78 +++++++
 misc-utils/copyfilerange.c                 | 226 +++++++++++++++++++++
 misc-utils/meson.build                     |   5 +
 tests/commands.sh                          |   1 +
 tests/expected/copyfilerange/copyfilerange |   4 +
 tests/ts/copyfilerange/copyfilerange       |  40 ++++
 11 files changed, 383 insertions(+)
 create mode 100644 misc-utils/copyfilerange.1.adoc
 create mode 100644 misc-utils/copyfilerange.c
 create mode 100644 tests/expected/copyfilerange/copyfilerange
 create mode 100755 tests/ts/copyfilerange/copyfilerange

-- 
2.51.1

