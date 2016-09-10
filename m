Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36180 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbcIJMCl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 10 Sep 2016 08:02:41 -0400
Received: by mail-wm0-f45.google.com with SMTP id b187so69975917wme.1
        for <util-linux@vger.kernel.org>; Sat, 10 Sep 2016 05:02:41 -0700 (PDT)
Received: from [192.168.1.102] ([5.102.242.30])
        by smtp.gmail.com with ESMTPSA id gg10sm8077715wjd.4.2016.09.10.05.02.38
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 05:02:38 -0700 (PDT)
To: util-linux@vger.kernel.org
From: Yuval Langer <yuval.langer@gmail.com>
Subject: Segmentation fault in line(1) - read one line
Message-ID: <7aae2006-c74d-0c6c-07b0-54c088082bab@gmail.com>
Date: Sat, 10 Sep 2016 15:02:37 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I am not sure if this is a real problem or not, but I have found the
following:

    $ line --version
    line from util-linux 2.27.1
    $ line <<< "$( printf '\naaaaaaaa' )"

    Segmentation fault (core dumped)
    $ line <<< "$( printf '\naaaaaaa' )"

    $

    $ lsb_release -a
    No LSB modules are available.
    Distributor ID: Ubuntu
    Description:    Ubuntu 16.04.1 LTS
    Release:        16.04
    Codename:       xenial

    $ uname -a
    Linux yankel-Lenovo-G505 4.4.0-36-generic #55-Ubuntu SMP Thu Aug 11
18:01:55 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

Many thanks,
Yuval Langer.
