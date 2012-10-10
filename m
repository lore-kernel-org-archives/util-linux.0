Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13768 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab2JJIg6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Oct 2012 04:36:58 -0400
Date: Wed, 10 Oct 2012 10:36:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Timothy Madden <terminatorul@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: `mount` command and POSIX Utility Syntax Guidelines
Message-ID: <20121010083655.GD28457@x2.net.home>
References: <k52bu0$1up$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <k52bu0$1up$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 10, 2012 at 02:28:06AM +0300, Timothy Madden wrote:
> I have the little annoying problem that I can not mount a DAV folder with
> the davfs2 filesystem, because I usually keep POSIXLY_CORRECT environment
> variable set. The var allows me to keep an "aliases" file (similar to
> ~/.basrc) and change it when needed if I put the file name in the ENV
> variable.

 Well, from my point of view is it mistake that getopt() supports
 something like $POSIXLY_CORRECT. It's application, not library, who
 has to control input/command line parsing.

 The shared libraries should be sensitive only to environment
 variables which control library private stuff or things which are
 really transparent to applications (LANG=...).

> Is it please possible for mount command to be updated to change the order of
> arguments on the command line, so that it follows the POSIX guidelines?

 The mount helpers command line is out documented API. I don't see a
 way how to change it without break the compatibility between mount(8)
 and mount.<type> helpers.

> At least when POSIXLY_CORRECT is set in the environment ?

 Don't assume that everyone uses getopt() from glibc. You can
 use "if (strcmp(argv[], ...))" to parse command line arguments.

 I think it would be better to remove POSIXLY_CORRECT from
 mount.<type> environment in mount(8) before we execute the helper.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
