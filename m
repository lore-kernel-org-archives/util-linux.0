Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35567 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdGOWpf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Jul 2017 18:45:35 -0400
Received: by mail-oi0-f66.google.com with SMTP id r74so619376oie.2
        for <util-linux@vger.kernel.org>; Sat, 15 Jul 2017 15:45:35 -0700 (PDT)
Subject: Re: [PATCH 0/5] pull: five mutually unrelated changes
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <20170715212046.1655-1-kerolasa@iki.fi>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <596A9B0D.6060400@gmail.com>
Date: Sat, 15 Jul 2017 17:45:33 -0500
MIME-Version: 1.0
In-Reply-To: <20170715212046.1655-1-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sami Kerola wrote:

> The 'big' change in this pull request is to drop reset(1) from util-linux.
> I don't think there is any point of keep this script hanging around.

Why do you think that.  I find it useful when some application corrupts 
the screen.  I realize that reset is a symlink to tset, but I find reset 
easier to remember/use.

   -- Bruce


