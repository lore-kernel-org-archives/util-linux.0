Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E061199939
	for <util-linux@vger.kernel.org>; Thu, 30 Jan 2025 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246296; cv=none; b=XCtX/QxY9Hrh8i0iTs0GSjmCAAimF8c6G0x8+JhZYuobVbEDd3wLUpp6NwjNUcEdzg8BBSVirt68FO8DaHTtyA7vK/9u8Pgyn6fycRM5CzWWbJ7GqwUFM8Wf3rrLS2J5tj7Z9XQCqkHNMtfdnF6smnlzO0PI8CnjXX8IIguN1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246296; c=relaxed/simple;
	bh=CPzdV+PbB/t/9SGaLZo24tp6AgsQNfd4Y8jV8eQ+1dU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g/YAd1VJOv928Vn1xyeXcdo5cpfspgYqeNo0uxXAkqatZEivx3J1GpGwajX7FCGjf3sQBxd1G/1DZKi+KH+U2/9bIc9emr8Om6ct6syWZPaeAI/DxuJgeL+y2pruDvfWfLLMD31+Zu43QShnvZB5F9iUSUeGuY9TgK2X8sj7CdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=HFbAUURa; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="HFbAUURa"
X-KPN-MessageId: 4b5ce2a8-df14-11ef-8d8a-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4b5ce2a8-df14-11ef-8d8a-005056aba152;
	Thu, 30 Jan 2025 15:12:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=p1kdGkhlFFL0oDwPnLwNx6D/cgwwB4c4XhBCRxGNr2M=;
	b=HFbAUURaqjosb3YjRI2JLy7BX2ajsZXqw9qvhDc4bE+0tnMnW1qqx/MRENf4UIQA64s1kHWNDhlVM
	 8OP3srpBD4RSfUJOTGgU3+aJ2CtP7xZo9SwkpLWcvvFfVHOKmCTy5nAVNml0ARjMYKPUfCyOlDu7SW
	 kcYgqWGt0dFDPgf0=
X-KPN-MID: 33|xpcpnr7iqMvH/6fMCwiYn0175TZLFUo6In4cPUsZ2r8A+J3yo6YXUEqTrNUcWY8
 IHpW+9TIEN/A6x750ZCgFlKPo3pX99ZkCZPd97cJ0X/g=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|7a3FxTu7YMufUVoqtFxkqlTWH0uhhPP3na0w2DSAme4B4MbjgX6PuGYKpoKeCfa
 EMtNaVhlhfmlPUqKA5qAX8A==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 1b524bcc-df14-11ef-9975-005056ab7447;
	Thu, 30 Jan 2025 15:11:32 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH] logger: grammarize the description of --socket-errors in the man page
Date: Thu, 30 Jan 2025 15:11:24 +0100
Message-ID: <20250130141124.29440-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/logger.1.adoc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/misc-utils/logger.1.adoc b/misc-utils/logger.1.adoc
index 1a5b4310a..a20736a3d 100644
--- a/misc-utils/logger.1.adoc
+++ b/misc-utils/logger.1.adoc
@@ -163,9 +163,15 @@ Most receivers accept messages larger than 1KiB over any type of syslog protocol
 Note: the message-size limit limits the overall message size, including the syslog header. Header sizes vary depending on the selected options and the hostname length. As a rule of thumb, headers are usually not longer than 50 to 80 characters. When selecting a maximum message size, it is important to ensure that the receiver supports the max size as well, otherwise messages may become truncated. Again, as a rule of thumb two to four KiB message size should generally be OK, whereas anything larger should be verified to work.
 
 *--socket-errors* __mode__::
-Print errors about Unix socket connections. The _mode_ can be a value of *off*, *on*, or *auto*. When the mode is *auto*, then *logger* will detect if the init process is *systemd*(1), and if so assumption is made _/dev/log_ can be used early at boot. Other init systems lack of _/dev/log_ will not cause errors that is identical with messaging using *openlog*(3) system call. The *logger*(1) before version 2.26 used *openlog*(3), and hence was unable to detected loss of messages sent to Unix sockets.
+Print errors about Unix socket connections. The _mode_ can be *on*, *off*, or *auto*.
+When the mode is *auto* (the default), then *logger* will detect if the init process
+is *systemd*(1), and if so, the assumption is made that _/dev/log_ can be used early
+at boot. The lack of _/dev/log_ on other init systems will not cause errors, just as
+when using the *openlog*(3) system call. The *logger*(1) before version 2.26 used
+*openlog*(3), and thus was unable to detect the loss of messages sent to Unix sockets.
 +
-The default mode is *auto*. When errors are not enabled lost messages are not communicated and will result to successful exit status of *logger*(1) invocation.
+When errors are not enabled, lost messages are not communicated and will result in a
+successful exit status of *logger*(1).
 
 *-T*, *--tcp*::
 Use stream (TCP) only. By default the connection is tried to the _syslog-conn_ port defined in _/etc/services_, which is often _601_.
-- 
2.48.1

