Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f195.google.com ([209.85.216.195]:32772 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbdCRTlz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 18 Mar 2017 15:41:55 -0400
Received: by mail-qt0-f195.google.com with SMTP id r45so13215534qte.0
        for <util-linux@vger.kernel.org>; Sat, 18 Mar 2017 12:41:54 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <6affdcde-0ec0-87ee-45f8-7da32ae1d1a5@gmail.com>
References: <6affdcde-0ec0-87ee-45f8-7da32ae1d1a5@gmail.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 18 Mar 2017 19:41:53 +0000
Message-ID: <CAG27Bk3uXbmBs9cY8gK34YJuUVEY11CdGB0-ibiTQ9feXg_9og@mail.gmail.com>
Subject: Re: sysfsutils, aka systool, candidate for inclusion in util-linux-ng
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: Karel Zak <kzak@redhat.com>,
        Ananth Mavinakayanahalli <ananth@in.ibm.com>,
        Daniel Stekloff <dsteklof@us.ibm.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 17 March 2017 at 17:47, Xose Vazquez Perez <xose.vazquez@gmail.com> wrote:
> Description: utilities for interfacing with sysfs.
>
> Background: unmaintained since ten years, included in
> enterprise distributions and widely used with plenty of
> downloads: https://sourceforge.net/projects/linux-diag/files/sysfsutils/stats/timeline?dates=2003-07-01++to+2017-03-17
>
>
> $HOME: https://linux-diag.sf.net/Sysfsutils.html
> Source code: https://sf.net/projects/linux-diag/files/sysfsutils/

Good proposal, and after quick test to migrate sysfsutils to
util-linux this seems
do-able. But before proceeding any further I want to hear from Karel and old
sysfsutils maintainer if the project merge what is wanted.

  git://github.com/kerolasa/lelux-utiliteetit.git sysfsutils

If yes next steps:

1. polish libsysfs, add for example .sym file
2. polish systool, add translations, and other standard util-linux
conventions, such as atexit hook, xmalloc usage, and so on
3. figure out what should be done with dlist_test, get_device,
get_driver, and get_module
4. add tests, and make _PART_SYS_SYSTEM stuff work
5. without a doubt something other as well
6. send a pull month or two later

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
