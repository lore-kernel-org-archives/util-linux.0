Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754015AbcJZKNV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Oct 2016 06:13:21 -0400
Date: Wed, 26 Oct 2016 12:13:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: libfdisk show stopper on i586?
Message-ID: <20161026101319.uazmjyk27kwhev46@ws.net.home>
References: <201610260000.12844.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201610260000.12844.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 26, 2016 at 12:00:12AM +0200, Ruediger Meier wrote:
> looks like some of the last commits between v2.29-rc2-1-ge5cc93b
> and v2.29-rc2-22-g82e8dda introduced issues on some i586 systems.
> 
> For example on  Fedora 19 i586:

I'm not able to reproduce this on 32bit (i686) CentOS 6.
Do you really have old Pentium (i586)? ;-)

Maybe you can try to debug it on your machine; just add "exit" to the
fdisk/gpt test before the problematic command, and then try execute
the commend by gcc or so.

Or try manually:

 # modprobe scsi_debug dev_size_mb=100
 # echo -e 'g\nw' | ./fdisk  <scsi-debug-disk>
 # ./fdisk -l <scsi-debug-disk>



> +/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libfdisk.so.1(fdisk_reset_labelitem+0x83)[0xf76ec2d3]
> +/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libfdisk.so.1(fdisk_get_disklabel_item+0x40)[0xf76f1700]
> +/home/abuild/rpmbuild/BUILD/util-linux-2.29.rc2-22-82e8d/.libs/libfdisk.so.1(fdisk_get_disklabel_id+0x5c)[0xf76f192c]

This reads disk GUID from GPT header for fdisk -l.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
