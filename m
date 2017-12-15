Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754389AbdLOMB2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 15 Dec 2017 07:01:28 -0500
Subject: Re: v2.31.1 plan
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20171214150026.7lk3mtwng5jbfcnf@ws.net.home>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <113c13c9-4bbe-28b2-ed4e-59c0b8f3f32c@gmx.de>
Date: Fri, 15 Dec 2017 13:01:23 +0100
MIME-Version: 1.0
In-Reply-To: <20171214150026.7lk3mtwng5jbfcnf@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12/14/2017 04:00 PM, Karel Zak wrote:
> 
>   I'd like to release stable maintenance v2.31.1 tomorrow or on Monday.
> 
>   All is already in stable/v2.31 branch:
>   https://github.com/karelzak/util-linux/tree/stable/v2.31
> 
>   See log below, comments & objections?

I have one, probably minor issue which I was too lazy to investigate
so far.

Test mount/fslists-type-pattern fails if you have /sbin/mount.exfat installed.

cu,
Rudi
