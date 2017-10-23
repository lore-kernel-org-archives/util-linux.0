Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f65.google.com ([209.85.215.65]:52168 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdJWQs1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 23 Oct 2017 12:48:27 -0400
Received: by mail-lf0-f65.google.com with SMTP id r129so20885291lff.8
        for <util-linux@vger.kernel.org>; Mon, 23 Oct 2017 09:48:26 -0700 (PDT)
MIME-Version: 1.0
From: Na Nha <minhnhan0801@gmail.com>
Date: Mon, 23 Oct 2017 23:48:25 +0700
Message-ID: <CAPiF6Th05_w6xE49Sym2XNLQrDPvrQ+74N1EcL2w9SESQ5ZpaA@mail.gmail.com>
Subject: Set_disksize_zram_LTP_testsuite
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

My name is Le Minh nhan, I am a Linux developer.

When I had used LTP testsuite to test our kernel, I encountered an error.
Testcase "zram02" of LTP testsuite  sets 100G disksize to zram, the
kernel says "cannot allocate memory". But there is no problem if I use
other values: 10G,20G...90G to set disksize of zram.

Could you please help me to find what the problem is?
What is the limitation of disksize I can set to zram or any suggestion
I could do?

I am so happy and grateful if you repsond my email.

Thanks and best regards,

Le Minh Nhan
