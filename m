Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:51657 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048AbbBATje (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 1 Feb 2015 14:39:34 -0500
Message-ID: <54CE80A2.1040008@gmx.com>
Date: Sun, 01 Feb 2015 14:38:10 -0500
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 8/8] docs: add the Sort command to the man page of cfdisk
References: <1422799213-16717-1-git-send-email-bensberg@justemail.net> <1422799213-16717-8-git-send-email-bensberg@justemail.net>
In-Reply-To: <1422799213-16717-8-git-send-email-bensberg@justemail.net>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 02/01/2015 09:00 AM, Benno Schulenberg wrote:
> Also sort T into its proper position, improve the wording of U,
> and add the Left and Right arrow keys.
> 
> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> ---
>  disk-utils/cfdisk.8 |   38 +++++++++++++++++++++++---------------
>  1 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
> index dc30b70..e4577d5 100644
> --- a/disk-utils/cfdisk.8
> +++ b/disk-utils/cfdisk.8
> @@ -66,9 +66,8 @@ Display version information and exit.
>  .BR \-z , " \-\-zero"
>  Start with an in-memory zeroed partition table.  This option does not zero the
>  partition table on the disk; rather, it simply starts the program without
> -reading the existing partition table.  This option allows to a create new
> -partition table from scratch or create a new partition table according to
> -a sfdisk compatible script.
> +reading the existing partition table.  This option allows you to create a new
> +partition table from scratch or from an sfdisk-compatible script.
>  
>  .SH COMMANDS
>  The commands for
> @@ -107,22 +106,27 @@ MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
>  Quit the program.  This will exit the program without writing any data to
>  the disk.
>  .TP
> -.B u
> -Dump the current in-memory partition table to the sfdisk compatible file.
> -.sp
> -The script files are compatible between cfdisk, sfdisk, fdisk and another
> -libfdisk applications. For more details see
> -.BR sfdisk (8).
> -.sp
> -It is also possible to load sfdisk script to cfdisk if there is no partition
> -table on the device or when you start cfdisk with \fI--zero\fR command line
> -option.
> +.B s
> +Sort the partitions in ascending start-sector order.  When deleting and
> +adding partitions, it is likely that the numbering of the partitions will
> +no longer match their order on the disk.  This command restores that match.
>  .TP
>  .B t
>  Change the partition type.  By default, new partitions are created as
>  .I Linux
>  partitions.
>  .TP
> +.B u
> +Dump the current in-memory partition table to an sfdisk-compatible script file.
> +.sp
> +The script files are compatible between \fBcfdisk\fR, \fBfdisk\fR, \fBsfdisk\fR
> +and other libfdisk applications.  For more details see
> +.BR sfdisk (8).
> +.sp
> +It is also possible to load an sfdisk-script into \fBcfdisk\fR if there is
> +no partition table on the device or when you start \fBcfdisk\fR with the
> +\fB--zero\fR command-line option.


 +It is also possible to load an sfdisk-script into \fBcfdisk\fR, if there is
 +no partition table on the device, or when you start \fBcfdisk\fR with the
 +\fB--zero\fR command-line option.


> +.TP
>  .B W
>  Write the partition table to disk (you must enter an uppercase W).  Since
>  this might destroy data on the disk, you must either confirm or deny
> @@ -143,13 +147,17 @@ Move the cursor to the previous or next partition.  If there are more
>  partitions than can be displayed on a screen, you can display the next
>  (previous) set of partitions by moving down (up) at the last (first)
>  partition displayed on the screen.
> +.TP
> +.IR "Left Arrow" , " Right Arrow"
> +Select the preceding or the next menu item.  Hitting \fIEnter\fR will
> +execute the currently selected item.
>  
>  .PP
>  All commands can be entered with either uppercase or lowercase
>  letters (except for
>  .BR W rite).
> -When in a submenu or at a prompt for entering a size, you can hit the
> -.I ESC
> +When in a submenu or at a prompt, you can hit the
> +.I Esc
>  key to return to the main menu.

s/can hit/may use/

>  
>  .SH COLORS
> 
