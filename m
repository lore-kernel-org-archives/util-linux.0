Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8321DF975
	for <util-linux@vger.kernel.org>; Fri, 13 Dec 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093528; cv=none; b=aD0JqROmzzKxvZrkJjwlSrUuANb2KZlpw1gdKBncxwUB50Okq8+S4Q2LwBpt/tbtyE3f2IVMCDMwSufUa2Ty2A90zKYQftn3Zt+xkYXjMTKrGUjXX5Xinnj8jIUOWK0pQEf2dnGxGCAGpo5mtv3p806pHTBgnLX8m5vEzF/D7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093528; c=relaxed/simple;
	bh=zk4o0WMUg12r9pN0u8Ni6mT/uR1Z1NZyG45lGughsNg=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=t8M6pNTQFUd5QJ2R1uLvVlvqpX2hQuQkxxk16FR8IAT1snHyw4qlShbxtaGfMA4WtkHxeyl3hlt2eoG1SgSVrIL64ORYQ973SnCJL5KtyPgL3yaRT6IMGgTtmtWPto7Mvc7fzqE0ajEkx1gCnH7ich81PdLWLX2dtsJ8PFwrrDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cirno.name; spf=pass smtp.mailfrom=cirno.name; dkim=fail (0-bit key) header.d=cirno.name header.i=@cirno.name header.b=PTjshKMF reason="key not found in DNS"; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cirno.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirno.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=cirno.name header.i=@cirno.name header.b="PTjshKMF"
Received: from mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5a2a:0:640:bba1:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id C53CA609EB
	for <util-linux@vger.kernel.org>; Fri, 13 Dec 2024 15:38:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ScL6Rh0OjuQ0-XeU7p2Ef;
	Fri, 13 Dec 2024 15:38:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirno.name; s=mail;
	t=1734093510; bh=RVEpW+ooJN0ItuGncbFdcJoeaMCs4JMzjpQpoEiYJ0w=;
	h=Subject:Cc:To:From:Date:Message-ID;
	b=PTjshKMF2k7MHWBQbVdbgxER/OzBC+BvTlaGfQ/pXjWf3Ymy0HTqdEmLRlhtnTSGA
	 Ys0913E6d0aqa/so9R6qHzHDrwCX1ChvmXWVXs1UzPy3/16RHB6RYHTi2sO0x8ESbo
	 xOq86jKCzGP/EX6D6h5PN0ZjB8z6qMy7bNra/Wuk=
Authentication-Results: mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net; dkim=pass header.i=@cirno.name
Message-ID: <2097ed76-2ed6-40da-9912-01774316370f@cirno.name>
Date: Fri, 13 Dec 2024 20:38:27 +0800
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: LiviaMedeiros <9@cirno.name>
To: util-linux@vger.kernel.org
Cc: LiviaMedeiros <livia@cirno.name>
Subject: [PATCH] tests: add skips when IPv6 is not supported
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

From: LiviaMedeiros <livia@cirno.name>

Before this change on systems with disabled IPv6 (e.g. `CONFIG_IPV6 is 
not set` in kernel config), `lsfd/mkfds-tcp6` and `lsfd/mkfds-udp6` were 
failing, and `lsfd/option-inet` was hanging forever, making it 
impossible to complete the tests.

Signed-off-by: LiviaMedeiros <livia@cirno.name>
---
  tests/functions.sh        | 6 ++++++
  tests/ts/lsfd/mkfds-tcp6  | 1 +
  tests/ts/lsfd/mkfds-udp6  | 1 +
  tests/ts/lsfd/option-inet | 1 +
  4 files changed, 9 insertions(+)

diff --git a/tests/functions.sh b/tests/functions.sh
index 630166871..add50440b 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -1195,3 +1195,9 @@ function ts_check_enosys_syscalls {
  function ts_skip_docker {
         test -e /.dockerenv && ts_skip "unsupported in docker environment"
  }
+
+function ts_check_ipv6 {
+       if [ ! -e /proc/net/if_inet6 ]; then
+               ts_skip "IPv6 is not supported"
+       fi
+}
diff --git a/tests/ts/lsfd/mkfds-tcp6 b/tests/ts/lsfd/mkfds-tcp6
index bffa630c4..414777f4a 100755
--- a/tests/ts/lsfd/mkfds-tcp6
+++ b/tests/ts/lsfd/mkfds-tcp6
@@ -23,6 +23,7 @@ ts_init "$*"
  ts_check_test_command "$TS_CMD_LSFD"
  ts_check_test_command "$TS_HELPER_MKFDS"
  ts_check_native_byteorder
+ts_check_ipv6
  ts_skip_docker

  ts_cd "$TS_OUTDIR"
diff --git a/tests/ts/lsfd/mkfds-udp6 b/tests/ts/lsfd/mkfds-udp6
index 26bdacd7c..59b1c06a2 100755
--- a/tests/ts/lsfd/mkfds-udp6
+++ b/tests/ts/lsfd/mkfds-udp6
@@ -23,6 +23,7 @@ ts_init "$*"
  ts_check_test_command "$TS_CMD_LSFD"
  ts_check_test_command "$TS_HELPER_MKFDS"
  ts_check_native_byteorder
+ts_check_ipv6
  ts_skip_docker

  ts_cd "$TS_OUTDIR"
diff --git a/tests/ts/lsfd/option-inet b/tests/ts/lsfd/option-inet
index 7ca883751..f679f121d 100755
--- a/tests/ts/lsfd/option-inet
+++ b/tests/ts/lsfd/option-inet
@@ -24,6 +24,7 @@ ts_skip_docker

  ts_check_test_command "$TS_CMD_LSFD"
  ts_check_test_command "$TS_HELPER_MKFDS"
+ts_check_ipv6

  ts_check_prog "mkfifo"

--
2.47.1
