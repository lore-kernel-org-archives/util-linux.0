Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72229C433F5
	for <util-linux@archiver.kernel.org>; Thu,  6 Jan 2022 14:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbiAFOjv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 6 Jan 2022 09:39:51 -0500
Received: from mail.hallyn.com ([178.63.66.53]:50628 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237699AbiAFOjv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Jan 2022 09:39:51 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 1B622B65; Thu,  6 Jan 2022 08:39:50 -0600 (CST)
Date:   Thu, 6 Jan 2022 08:39:50 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: su currently requires PAM
Message-ID: <20220106143950.GB24764@mail.hallyn.com>
References: <0616772a-c45c-d003-c338-45dd7071fb70@gmail.com>
 <20220106132746.pcxng3anm5kave6w@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106132746.pcxng3anm5kave6w@ws.net.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jan 06, 2022 at 02:27:46PM +0100, Karel Zak wrote:
> On Mon, Dec 27, 2021 at 09:26:01AM -0600, Bruce Dubbs wrote:
> > In linuxfromscratch, we have been using su from the shadow package because
> > the util-linux version requires Linux-PAM.  Recently the maintainers of
> > shadow have announced that they are deprecating su.  Our problem is that
> > some of our users prefer to not install PAM.
> 
> I had a discussion about it with Serge (in CC), it seems the current
> the conclusion is that "for now shadow will have to keep shipping su".

I haven't mentioned it in the Changelog, but have implied here
https://github.com/shadow-maint/shadow/issues/464
that yes we will not drop su in shadow until there is an alternative.

> > Is it possible to make the requirement of Linux-PAM optional in the
> > util-linux version of su?  From a preliminary inspection of the code, it
> > looks like only login-utils/su-common.c would need to be modified with some
> > #ifdef constructs, but I am not completely comfortable doing that myself.
> 
> The problem is not #ifdef, but that you need local reimplementation
> for the very basic PAM functionality.                    
> 
> I have suggested creating some minimalistic library with PAM
> compatible API, but without all the functionality. Maybe we can
> develop this library in util-linux and later offer it to other
> projects. Volunteers? ;-)
>                                                          
> Another possibility is to improve the original PAM to make it possible
> to compile it without modules, etc.          
> 
>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
