Return-Path: util-linux-owner@vger.kernel.org
Received: from nagini.codelibre.net ([80.68.93.164]:43150 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609Ab3CNAaH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Mar 2013 20:30:07 -0400
Date: Thu, 14 Mar 2013 00:21:47 +0000
From: Roger Leigh <rleigh@codelibre.net>
To: Util-Linux <util-linux@vger.kernel.org>
Subject: A few small findmnt/mount issues
Message-ID: <20130314002147.GR23093@codelibre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Just noticed a few minor deficiencies:

- findmnt does not have column types for DUMP and PASS, so it's
  not possible to get at all the fstab information when using the
  --fstab option, unless there's a way of doing this I'm unaware
  of.  For completeness, it would be very useful to be able to
  retrieve all fstab(5) fields.  This would mean all access to
  mtab and fstab can go via findmnt in our init scripts.

- utab isn't updated on remount for _netdev:
  If I have an fstab entry with _netdev in the fs_mntopts, this
  will get stored in utab when I run "mount /foo".  However, if
  I want to add the option after mount and use
  "mount -o remount,_netdev /foo", this does not cause utab to
  be updated.

  While this might appear contrived, we do actually make use of this
  when filesystems mounted in an initramfs using busybox mount are
  remounted with additional options from fstab with the util-linux
  mount after init starts.  When we had a static mtab, the _netdev
  option would have been added at this point; with utab, we would
  ideally like to be able to update the option via the mount
  interface.  Tested this with 2.20.1, but looking at the source
  looks like it's probably still present unless I misunderstood it.
  May also affect other mount options?

Is there a preferred bugtracker you would like things like this
reporting, or is here OK?


Kind regards,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux    http://people.debian.org/~rleigh/
 `. `'   schroot and sbuild  http://alioth.debian.org/projects/buildd-tools
   `-    GPG Public Key      F33D 281D 470A B443 6756 147C 07B3 C8BC 4083 E800
