Received: from m239-4.eu.mailgun.net (m239-4.eu.mailgun.net [185.250.239.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C536D4F0
	for <util-linux@vger.kernel.org>; Sun, 23 Nov 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.239.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763911985; cv=none; b=nHT1xrwvPK/dqQ4fqeQHcJjc069hfu7H4PKPs4JgJU1kD9HJS2o9fC5xugTYcAZIFpgcjIU6LuEcTHyrKKvHBMuvhwJ8J1zbyO7xrQqKk6GdkFCP00B78mp/R/zRLciiVEu5wo7BUyfKvxgRyP46dEvDC82pOqQMgs+NC0/vpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763911985; c=relaxed/simple;
	bh=E7DYMq90f0NRaCKD+wdniFr7Yr5fc8VhKPatUWJRq7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u9xm+NA8HCyc2kf+pWTQAMbQ4FYtb3FRDDKa668B25RJGfb3sjGtAzr6JumWT9t8ffJVaGev962unGOPAiEVEsK5GRXRCAd3yjU3ugr96FgL8oXi3w0Qp7wkKTX9HFCpW/V5PJWit6pXNEmM9BtlZGOD06eL9SMqK6mfX4VqbrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=GvPyakIy; arc=none smtp.client-ip=185.250.239.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="GvPyakIy"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1763911981; x=1763919181;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=lrayAPS/BO7s4BUjURNIdPEu8A4uzKI9IYfoyMWJPq8=;
 b=GvPyakIy/NK80eA2EznDQ7T9kytbm/hJQnVCqhu+dxNme7K/eXHGwejSPAA5WVsly/jygLejz/Tu+Uatq3+9D6xZDxa1zHLAKFgGg7RQueC2MWOmSJo7l9PMN+lYE8DXYB7dogCNzP2OYmqF60PricMATX5uEHBQuoPB4taeRv6Ud1jgsMuMQyNfszUeTe7PnoowKGF753i9iLso0EAldgHIxLqC6rQ4eb0nqOW1nkGAvC/k72bI3onuXNRGBIMQH6a5sk/Y78k9KvDrf2BRJ2E3+3qwcdcOs3S2WZ/0wbljnQYabkAci/7BCUfk1It3p64KqD6yenv2N8x24Gds4A==
X-Mailgun-Sid: WyJlNDM3YyIsInV0aWwtbGludXhAdmdlci5rZXJuZWwub3JnIiwiNTRlZjQiXQ==
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 7cb349a42b1b1f1259b38414f775f2c20b6e7347a6127f8df26891016837968f with SMTP id
 6923292dced19bbbbb7bfa04; Sun, 23 Nov 2025 15:33:01 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
Sender: alessandro@0x65c.net
From: Alessandro Ratti <alessandro@0x65c.net>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com,
	thomas@t-8ch.de,
	Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH 0/3] Consistent shell resolution across util-linux
Date: Sun, 23 Nov 2025 16:32:43 +0100
Message-ID: <20251123153246.1056874-1-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series addresses inconsistent default shell handling across
util-linux tools, which caused user-reported data loss when script(1)
defaulted to /bin/sh without respecting the user's configured shell.

The series:
1. Introduces ul_default_shell() for consistent shell resolution
2. Updates interactive tools to use the new function
3. Standardizes _PATH_BSHELL usage in security-sensitive tools

This implements the solution discussed in:
https://github.com/util-linux/util-linux/issues/3865

Alessandro Ratti (3):
  lib: introduce ul_default_shell() for consistent shell resolution
  *: use ul_default_shell() for interactive shell spawning
  login-utils, sys-utils: use _PATH_BSHELL consistently

 include/shells.h        |  6 ++++++
 lib/Makemodule.am       |  1 +
 lib/exec_shell.c        |  8 ++------
 lib/shells.c            | 26 ++++++++++++++++++++++++++
 login-utils/su-common.c |  5 +----
 login-utils/sulogin.c   |  9 +++++----
 sys-utils/flock.c       |  8 +++++---
 sys-utils/setpriv.c     |  6 ++----
 term-utils/script.c     |  5 ++---
 term-utils/scriptlive.c |  5 ++---
 text-utils/more.c       |  4 ++--
 11 files changed, 54 insertions(+), 29 deletions(-)

-- 
2.51.1

