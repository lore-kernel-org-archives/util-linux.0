Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753761AbeCFOd1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Mar 2018 09:33:27 -0500
Date: Tue, 6 Mar 2018 15:33:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Ludwig Nussel <ludwig.nussel@suse.de>, util-linux@vger.kernel.org
Subject: Re: agetty /etc/issue handling
Message-ID: <20180306143323.ssny4nslxnmsuoxu@ws.net.home>
References: <2fb8c760-3be8-a77f-0ab1-ad67ebca63cb@suse.de>
 <20180306104110.k4tis2b23eqykqeh@ws.net.home>
 <5089360b-0a43-d754-ebd0-2d428af1c1af@suse.de>
 <201803061451.37202.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201803061451.37202.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 06, 2018 at 02:51:36PM +0100, Ruediger Meier wrote:
> To be honest, I don't really like that emergency-critical things like 
> agetty will need to read dozens of files from many different file 
> systems ... just for cosmetical reasons. IMO a 3rd party 
> issue-generator is the better way.

All the stuff should be optional.

The reason is that growing number of use-cases where specific
subsystem or software want to print any information by the issue file.
(I mean containers, virtualization, serial line redirections/switches,
etc.)

We don't want to store generated things in /etc (read-only, state-less
machines, ...), so at least /run (usually tmpfs) seems like good choice.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
