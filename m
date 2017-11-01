Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752395AbdKAOrH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 1 Nov 2017 10:47:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72A7662E96
        for <util-linux@vger.kernel.org>; Wed,  1 Nov 2017 14:47:07 +0000 (UTC)
Date: Wed, 1 Nov 2017 15:47:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Prarit Bhargava <prarit@redhat.com>
Cc: util-linux@vger.kernel.org, anderson@redhat.com
Subject: Re: [PATCH] dmesg: Add force-prefix option
Message-ID: <20171101144703.adnh6nnft2c3f5qv@ws.net.home>
References: <20171031120131.5837-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171031120131.5837-1-prarit@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 31, 2017 at 08:01:31AM -0400, Prarit Bhargava wrote:
> The kernel outputs multi-line messages (kernel messages that contain
> the end-of-line character '\n').  These message are currently displayed by
> dmesg as
> 
> [965199.028940] runnable tasks:
>                            task   PID         tree-key  switches  prio
> wait-time             sum-exec        sum-sleep
>                 ----------------------------------------------------------------------------------------------------------
> 
> The kernel timestamps each of these lines with [965199.028940] and the
> dmesg utility should do the same.
> 
> Add the 'force-prefix'/'-p' dmesg option to add decode & timestamp information
> to each line of a multi-line message.
> 
> Notes: The new print_record() algorithm stores the decode & timestamp
> information in buffers.  If the force-prefix option is used, the message is
> split into separate lines and each line is prefixed with the stored decode &
> timestamp information.  The splitting of the message into separate lines is
> done using strtok() which requires write access to the message buffer (ie, the
> const message buffer is now copied into a writeable buffer).
> 
> Successfully tested by me by looking at sysrq-t and sysrq-w output.
> All known good /tests passed with these changes.

Merged with some changes:

     - use snprintf()
     - cleanup \n usage (don't count line break to the
       message text in the parsers  and always print \n after the text
     - add the option to the man page
     - use --force-prefix for kmsg only, old syslog(2) API splits messages itself
     - strdup() the message text only on force-prefix

Please, test it again :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
