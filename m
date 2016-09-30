Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752376AbcI3LLH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 30 Sep 2016 07:11:07 -0400
Date: Fri, 30 Sep 2016 13:11:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Yuval Langer <yuval.langer@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Segmentation fault in line(1) - read one line
Message-ID: <20160930111105.erqpaafvye2olz7q@ws.net.home>
References: <7aae2006-c74d-0c6c-07b0-54c088082bab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7aae2006-c74d-0c6c-07b0-54c088082bab@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 10, 2016 at 03:02:37PM +0300, Yuval Langer wrote:
> I am not sure if this is a real problem or not, but I have found the
> following:
> 
>     $ line --version
>     line from util-linux 2.27.1

the current stable is 2.28.2

>     $ line <<< "$( printf '\naaaaaaaa' )"
> 
>     Segmentation fault (core dumped)
>     $ line <<< "$( printf '\naaaaaaa' )"

it seems fixed in the current upstream tree

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
