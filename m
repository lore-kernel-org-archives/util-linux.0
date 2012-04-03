Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3541 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538Ab2DCNi4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Apr 2012 09:38:56 -0400
Date: Tue, 3 Apr 2012 15:38:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 12/20] uuidd: --socket-activation implies --keep-privs
Message-ID: <20120403133828.GJ1084@x2.net.home>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-13-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333039528-24784-13-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 29, 2012 at 06:45:20PM +0200, Petr Uzel wrote:
> +process.  Implies --no-fork, --no-pid and --keep-privs.  As of this writing,
> +this option is supposed to be used only with systemd. It needs to enabled with
> +configure option --enable--uuid-socket-activation.

 It would be better to add a NOTES section to the man page and add there
 a note about socket activation.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
