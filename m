Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18065 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbcJKOUs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 11 Oct 2016 10:20:48 -0400
Date: Tue, 11 Oct 2016 16:19:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org,
        Federico Bento <up201407890@alunos.dcc.fc.up.pt>
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
Message-ID: <20161011141955.gtz7u3zdsrgaqkjx@ws.net.home>
References: <56D7409A.6050407@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <56D7409A.6050407@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 02, 2016 at 08:35:54PM +0100, Stanislav Brabec wrote:
> Another possible fixes would be:
> - Or create custom pty container (like script does).

note that for pty container you have to call setsid() otherwise in
session running shell has to control the terminal.

...
> To prevent unwanted reading from a terminal, one would:
> - Or create custom pty container (like script does).

 I'd like to cleanup all su(1) code, use signalfd and then add new
 features (for v2.30), because the current code is horrible from my
 point of view. 
 
 Anyway, I have tried to implement experimental --pty option to the
 current code. See su-pty branch on github. (It's very raw...).
 
 The problem is again (like script(1)) non-terminal stdin 
 and pty session mix

    echo AxA | su - kzak --pty -c "sed 's/x/A/'"

 this use-case is disabled for now.

 # tty
 /dev/pts/0
 
 # runuser -u kzak tty 
 /dev/pts/0

 # runuser -u kzak --pty tty 
 /dev/pts/4

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
