Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbdAaMDf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 31 Jan 2017 07:03:35 -0500
Date: Tue, 31 Jan 2017 13:03:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Pedro Miguel Carvalho <PedroMC@pmc.com.pt>
Cc: util-linux@vger.kernel.org
Subject: Re: [PROBLEM] "findmnt --poll" does not flush stdout causing it to
 buffer the output more than it should when the output is to a pipe or file.
Message-ID: <20170131120322.ga4eip54poeqk2qi@ws.net.home>
References: <1493264.gvqBJzGE5V@marte>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493264.gvqBJzGE5V@marte>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 20, 2017 at 02:49:18PM +0000, Pedro Miguel Carvalho wrote:
> "findmnt --poll" does not flush stdout causing it to buffer the
> output more than it should when the output is to a pipe or file.

Fixed. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
