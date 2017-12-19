Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35614 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdLSUf6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 Dec 2017 15:35:58 -0500
Received: by mail-oi0-f52.google.com with SMTP id 184so13273447oii.2
        for <util-linux@vger.kernel.org>; Tue, 19 Dec 2017 12:35:58 -0800 (PST)
Received: from [192.168.0.76] (cpe-70-123-251-100.satx.res.rr.com. [70.123.251.100])
        by smtp.gmail.com with ESMTPSA id r22sm4953978ota.50.2017.12.19.12.35.57
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Dec 2017 12:35:57 -0800 (PST)
To: Util-Linux <util-linux@vger.kernel.org>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: Regression test failure
Message-ID: <5A39782D.1030608@gmail.com>
Date: Tue, 19 Dec 2017 14:35:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In version 2.31.1, I had one failure:

fincore: count file contents in core   ... FAILED (fincore/count)

   1 tests of 200 FAILED

$ cat ./tests/diff/fincore/count
--- /sources/util-linux-2.31.1/tests/expected/fincore/count.4096 
2017-09-18 09:48:03.676890826 +0000
+++ /sources/util-linux-2.31.1/tests/output/fincore/count       2017-12-19 
20:18:24.410460239 +0000
@@ -13,7 +13,7 @@
  return value: 0
      0  8192 i_TWO_PAGES_directio_
  return value: 0
-    1  8192 i_TWO_PAGES_mixed_directio_incore_
+    2  8192 i_TWO_PAGES_mixed_directio_incore_
  return value: 0
      1  8192 i_TWO_PAGES_mixed_incore_directio_
  return value: 0
@@ -42,7 +42,7 @@
      0      4096 i_JUST_PAGESIZE_directio_
      2      8192 i_TWO_PAGES_incore_
      0      8192 i_TWO_PAGES_directio_
-    1      8192 i_TWO_PAGES_mixed_directio_incore_
+    2      8192 i_TWO_PAGES_mixed_directio_incore_
      1      8192 i_TWO_PAGES_mixed_incore_directio_
      2 134213632 i_WINDOW_SIZE_incore-sparse-incore_
      0 134213632 i_WINDOW_SIZE_directio-sparse-directio_

-----------------------
The system is a fresh LFS build (systemd version):

./configure ADJTIME_PATH=/var/lib/hwclock/adjtime   \
             --docdir=/usr/share/doc/util-linux-2.31 \
             --disable-chfn-chsh  \
             --disable-login      \
             --disable-nologin    \
             --disable-su         \
             --disable-setpriv    \
             --disable-runuser    \
             --disable-pylibmount \
             --disable-static     \
             --without-python

make

chown -Rv nobody .
su nobody -s /bin/bash -c "PATH=$PATH make -k check"

   -- Bruce
