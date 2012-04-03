Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38208 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab2DCNcy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Apr 2012 09:32:54 -0400
Date: Tue, 3 Apr 2012 15:32:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux@vger.kernel.org, "Ted Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 11/20] uuidd: introduce --keep-privs option
Message-ID: <20120403133226.GI1084@x2.net.home>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-12-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333039528-24784-12-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 29, 2012 at 06:45:19PM +0200, Petr Uzel wrote:
> This option makes uuidd _not_ to drop its privileges if installed suid
> and exectued by root.
> 
> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> ---
>  misc-utils/uuidd.8 |    5 +++++
>  misc-utils/uuidd.c |    7 ++++++-
>  2 files changed, 11 insertions(+), 1 deletions(-)

 Please, drop this patch.

 For socket activation we can use the "drop_privs = 0" internally, it's
 unnecessary to export this functionality to command line.


 Anyway, do we really need to support suid uuidd? What about to drop
 all this stuff and require that uuidd has to be started by init
 scripts only? What about to drop exec-from-library at all?

 RHEL/Fedora/Suse starts uuidd by init, and for another distros is
 whole uuidd almost unnecessary thing... It seems that Debian uses
 suid uuidd, but I think that they can add an init script too.

 IMHO the current exec-from-library and suid is not elegant solution.

 Ted?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
