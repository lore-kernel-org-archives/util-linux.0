Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751648AbdCUEY2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 21 Mar 2017 00:24:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2L4Nblr120994
        for <util-linux@vger.kernel.org>; Tue, 21 Mar 2017 00:23:45 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0a-001b2d01.pphosted.com with ESMTP id 29ak411muy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Tue, 21 Mar 2017 00:23:45 -0400
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <ananth@linux.vnet.ibm.com>;
        Mon, 20 Mar 2017 22:23:44 -0600
Date: Tue, 21 Mar 2017 09:53:36 +0530
From: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: Sami Kerola <kerolasa@iki.fi>, Karel Zak <kzak@redhat.com>,
        Daniel Stekloff <dan@wendan.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: sysfsutils, aka systool, candidate for inclusion in util-linux-ng
Reply-To: ananth@linux.vnet.ibm.com
References: <6affdcde-0ec0-87ee-45f8-7da32ae1d1a5@gmail.com>
 <CAG27Bk3uXbmBs9cY8gK34YJuUVEY11CdGB0-ibiTQ9feXg_9og@mail.gmail.com>
 <000ad5f7-f6cf-a54a-f6c9-405ad4017cda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000ad5f7-f6cf-a54a-f6c9-405ad4017cda@gmail.com>
Message-Id: <20170321042336.GG24841@in.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 18, 2017 at 08:58:41PM +0100, Xose Vazquez Perez wrote:
> On 03/18/2017 08:41 PM, Sami Kerola wrote:
> 
> > On 17 March 2017 at 17:47, Xose Vazquez Perez <xose.vazquez@gmail.com> wrote:
> >> Description: utilities for interfacing with sysfs.
> >>
> >> Background: unmaintained since ten years, included in
> >> enterprise distributions and widely used with plenty of
> >> downloads: https://sourceforge.net/projects/linux-diag/files/sysfsutils/stats/timeline?dates=2003-07-01++to+2017-03-17
> >>
> >>
> >> $HOME: https://linux-diag.sf.net/Sysfsutils.html  <--- HTTPS broken!!
> >> $HOME: http://linux-diag.sf.net/Sysfsutils.html
> >> Source code: https://sf.net/projects/linux-diag/files/sysfsutils/
> > 
> > Good proposal, and after quick test to migrate sysfsutils to
> > util-linux this seems
> > do-able. But before proceeding any further I want to hear from Karel and old
> > sysfsutils maintainer if the project merge what is wanted.
> > 
> >   git://github.com/kerolasa/lelux-utiliteetit.git sysfsutils
> > 
> > If yes next steps:
> > 
> > 1. polish libsysfs, add for example .sym file
> > 2. polish systool, add translations, and other standard util-linux
> > conventions, such as atexit hook, xmalloc usage, and so on
> > 3. figure out what should be done with dlist_test, get_device,
> > get_driver, and get_module
> > 4. add tests, and make _PART_SYS_SYSTEM stuff work
> > 5. without a doubt something other as well
> > 6. send a pull month or two later
> 
> Cced the rest of the sysfsutils crew.

While I wrote large parts of the code about 13/14 years ago, I haven't
worked on it for over a decade. If it is being used as is, that's good
to know. Let me know if anything specific is needed from my end.

Regards,
Ananth

