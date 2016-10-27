Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965370AbcJ0OCK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 27 Oct 2016 10:02:10 -0400
Date: Thu, 27 Oct 2016 12:25:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: lscpu VMWARE bdoor patch
Message-ID: <20161027102515.qw47rdgn72qingfi@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi,

this is lscpu output on my machine:

    Virtualization:        VT-x
    Hypervisor vendor:     VMware
    Virtualization type:   full


I have nothing like VMWARE. It seem the code (commit b7744730) does
not work as expected for non-root users. What about to add 

    if (getuid() != 0)
        return 0;

to the is_vmware_platform() function?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
