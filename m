Received: from dsmtpq3-prd-nl1-vfz.edge.unified.services (dsmtpq3-prd-nl1-vfz.edge.unified.services [84.116.6.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A779CF
	for <util-linux@vger.kernel.org>; Tue,  2 Dec 2025 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.116.6.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706670; cv=none; b=Q71Nx1TDF6qNhiyUgZD7plJa4Dp2Y5bwn39KSP5FU4e71DfB5m/AcbnG3+1sYtTvPr0nUZC5/ULbeUyyzBrGcU1WjZe+kRJhB6I2gbcgpZobRBJTnzGHi2nifb7wkxFbu0Y3FcVt1PLbwsuYnLHSAgcxEoaBlfX8V7dfu//fO8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706670; c=relaxed/simple;
	bh=nmjOGzohmk/Dk3lHke2aqu7l5SXEVvYNJrNNlpz0fOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdTEC+2mCxk+VuiMoD/DDzf+nwokH9+TJKsukvH+H+1nTm9H2slizctulpRBTxyfkYtAOJ+FmoNWEB+kfSlSrdC/S+2QBQ5s/aB/eYfSXGBbjQ8j+KE6qh1hNnLNzL6jBYHy0sbCuyuSCmTA7sXWRsM2hvLouf/jrxwdX7O2pcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl; spf=none smtp.mailfrom=mrns.nl; arc=none smtp.client-ip=84.116.6.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mrns.nl
Received: from csmtpq2-prd-nl1-vfz.edge.unified.services ([84.116.50.17])
	by dsmtpq3-prd-nl1-vfz.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <dick@mrns.nl>)
	id 1vQWma-0011dV-KX
	for util-linux@vger.kernel.org;
	Tue, 02 Dec 2025 21:15:32 +0100
Received: from csmtp4-prd-nl1-vfz.nl1.unified.services ([100.107.80.23] helo=csmtp4-prd-nl1-vfz.edge.unified.services)
	by csmtpq2-prd-nl1-vfz.edge.unified.services with esmtp (Exim 4.95)
	(envelope-from <dick@mrns.nl>)
	id 1vQWmT-0049vC-2M
	for util-linux@vger.kernel.org;
	Tue, 02 Dec 2025 21:15:25 +0100
Received: from routi.mrns.nl ([212.204.155.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by csmtp4-prd-nl1-vfz.edge.unified.services with ESMTPSA
	id QWmRvgkHgimrqQWmRvMyGl; Tue, 02 Dec 2025 21:15:24 +0100
X-Env-Mailfrom: dick@mrns.nl
X-Env-Rcptto: util-linux@vger.kernel.org
X-SourceIP: 212.204.155.133
X-CNFS-Analysis: v=2.4 cv=R62p39RX c=1 sm=1 tr=0 ts=692f48dd cx=a_exe
 a=+NQzl7YsTyKB6E3DpOjMZQ==:117 a=+NQzl7YsTyKB6E3DpOjMZQ==:17
 a=wP3pNCr1ah4A:10 a=4425vRj2VURtf0qpTaoA:9
X-Authenticated-Sender: ieb1yoh3@ziggo.nl
Received: by routi.mrns.nl (sSMTP sendmail emulation); Tue, 02 Dec 2025 21:15:23 +0100
From: Dick Marinus <dick@mrns.nl>
To: util-linux@vger.kernel.org
Cc: Dick Marinus <dick@mrns.nl>
Subject: [PATCH 0/1] copyfilerange: new command to call copy-file-range
Date: Tue,  2 Dec 2025 21:14:17 +0100
Message-ID: <20251202201500.1029349-1-dick@mrns.nl>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOMYiN5IOj+ssupi/a5avGdPWjETQU1BajhVpTyS63mOa8B2O0NRxn0OgXVwU5+mSH2qPCTgmwdYppIDQQXSdyxzX8Bn2DlRiX6n/ZxY6M7X0CIQuLcr
 szkJVPIgsFIVUzRHH/XnqAld7kNT1JN7GDk2MJds6hTGxbCeHKDnspiP+6q7yXhr+oG/zpmzdEBabRvwUWyUh+Oohg3L7dRyAGo=

Hello!

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

