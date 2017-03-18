Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36017 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdCRT6p (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 18 Mar 2017 15:58:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id x124so8333082wmf.3
        for <util-linux@vger.kernel.org>; Sat, 18 Mar 2017 12:58:44 -0700 (PDT)
Subject: Re: sysfsutils, aka systool, candidate for inclusion in util-linux-ng
To: Sami Kerola <kerolasa@iki.fi>, Karel Zak <kzak@redhat.com>,
        Ananth Mavinakayanahalli <ananth@in.ibm.com>,
        Daniel Stekloff <dan@wendan.org>,
        Mohan Kumar <mohan@in.ibm.com>,
        Nitin Vashisth <vnitin@in.ibm.com>
References: <6affdcde-0ec0-87ee-45f8-7da32ae1d1a5@gmail.com>
 <CAG27Bk3uXbmBs9cY8gK34YJuUVEY11CdGB0-ibiTQ9feXg_9og@mail.gmail.com>
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-ID: <000ad5f7-f6cf-a54a-f6c9-405ad4017cda@gmail.com>
Date: Sat, 18 Mar 2017 20:58:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAG27Bk3uXbmBs9cY8gK34YJuUVEY11CdGB0-ibiTQ9feXg_9og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/18/2017 08:41 PM, Sami Kerola wrote:

> On 17 March 2017 at 17:47, Xose Vazquez Perez <xose.vazquez@gmail.com> wrote:
>> Description: utilities for interfacing with sysfs.
>>
>> Background: unmaintained since ten years, included in
>> enterprise distributions and widely used with plenty of
>> downloads: https://sourceforge.net/projects/linux-diag/files/sysfsutils/stats/timeline?dates=2003-07-01++to+2017-03-17
>>
>>
>> $HOME: https://linux-diag.sf.net/Sysfsutils.html  <--- HTTPS broken!!
>> $HOME: http://linux-diag.sf.net/Sysfsutils.html
>> Source code: https://sf.net/projects/linux-diag/files/sysfsutils/
> 
> Good proposal, and after quick test to migrate sysfsutils to
> util-linux this seems
> do-able. But before proceeding any further I want to hear from Karel and old
> sysfsutils maintainer if the project merge what is wanted.
> 
>   git://github.com/kerolasa/lelux-utiliteetit.git sysfsutils
> 
> If yes next steps:
> 
> 1. polish libsysfs, add for example .sym file
> 2. polish systool, add translations, and other standard util-linux
> conventions, such as atexit hook, xmalloc usage, and so on
> 3. figure out what should be done with dlist_test, get_device,
> get_driver, and get_module
> 4. add tests, and make _PART_SYS_SYSTEM stuff work
> 5. without a doubt something other as well
> 6. send a pull month or two later

Cced the rest of the sysfsutils crew.
