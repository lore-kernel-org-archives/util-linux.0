Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbdEEKVf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 5 May 2017 06:21:35 -0400
Date: Fri, 5 May 2017 12:21:31 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: column tree id-parent loop crash
Message-ID: <20170505102131.bmytzts2oi3enqme@ws.net.home>
References: <CAG27Bk1XLAD3yK7EcuzrsCF5zj4wT0sAMjk4X=a3SB9+RQ1JWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAG27Bk1XLAD3yK7EcuzrsCF5zj4wT0sAMjk4X=a3SB9+RQ1JWA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 04, 2017 at 09:53:21PM +0100, Sami Kerola wrote:
> Hi Karel,
> 
> $ printf "%s\n%s\n" "a 1 0" "b 0 1" | column
> --table-columns=NAME,ID,PARENT --tree NAME --tree-id ID --tree-parent
> PARENT
> Segmentation fault (core dumped)
> 
> I'm not sure what the command should do in this case. Maybe print some
> sort of symbol of circle, such as below??

The library does not support such symbol, it seems better silently
ignore such dependence and use only parent->child and ignore
child->parent part of the loop. 

Fixed.

For example

echo -e '1 5 AA\n2 1 AA.A\n3 1 AA.B\n4 2 AA.A.A\n5 2 AA.A.B' | ./column --tree 3 --tree-id 1 --tree-parent 2
1  5  AA
2  1  ├─AA.A
4  2  │ ├─AA.A.A
5  2  │ └─AA.A.B
3  1  └─AA.B

echo -e '1 5 AA\n2 1 AA.A\n3 1 AA.B\n4 2 AA.A.A\n5 1 AA.A.B' | ./column --tree 3 --tree-id 1 --tree-parent 2
1  5  AA
2  1  ├─AA.A
4  2  │ └─AA.A.A
3  1  ├─AA.B
5  1  └─AA.A.B

works as expected, although AA and AA.A.B have loop in dependencies. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
