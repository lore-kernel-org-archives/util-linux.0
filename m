Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751514AbdJWKxv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 23 Oct 2017 06:53:51 -0400
Date: Mon, 23 Oct 2017 12:53:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Jeff Sadowski <jeff.sadowski@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: wall logging or run command each post?
Message-ID: <20171023105347.e6k3xwnwmhvgfzgw@ws.net.home>
References: <CAM9ceLjMPtUHNxj-G2YL=5w+dE+EoD+6rYKE1uDCDn5k19z8gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAM9ceLjMPtUHNxj-G2YL=5w+dE+EoD+6rYKE1uDCDn5k19z8gw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 18, 2017 at 02:06:25PM -0600, Jeff Sadowski wrote:
> I would like to know if this feature is built into wall or is there a
> good work around?

wall is usually used by superuser. I guess if you can all "wall" than
you can also call for example logger to write to the system logs. I
don't see reason to merge functionally of these tools together.

> I would like to configure wall to run a script after anything is posted to wall.

Why? Maybe there is better way go get your goal.

> I would also like to log all wall messages. I could easily do that
> with a script.

yes, script(1) is the right way

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
