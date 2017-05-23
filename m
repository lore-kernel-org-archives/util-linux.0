Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751942AbdEWH5i (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 May 2017 03:57:38 -0400
Date: Tue, 23 May 2017 09:57:33 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: versioning
Message-ID: <20170523075733.wwlzrff6atybmsal@ws.net.home>
References: <201705172107.49456.sweet_f_a@gmx.de>
 <20170517210953.dskdxcr3rdmbtvgs@ws.net.home>
 <CAG27Bk17xasjeZQP6YpzUvchZJ5mtG2K4w0dirRybxu98-pAcQ@mail.gmail.com>
 <20170518103640.3dedmk7lat74biev@ws.net.home>
 <24e52021-2e94-68a7-bd8c-51362af1d749@gmx.com>
 <20170518195648.gxhsd4zak57wfcg3@ws.net.home>
 <2d5ad507-f51c-7b1b-3aa3-355609cb609c@gmx.de>
 <dfa49f1d-e310-667a-20d3-897bbff2ea83@gmx.com>
 <20170520193446.bt44te35kji2gmzo@ws.net.home>
 <b6e7901f-4df8-6842-0475-0290d110f68e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b6e7901f-4df8-6842-0475-0290d110f68e@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 22, 2017 at 05:37:28PM -0400, J William Piggott wrote:
> My thoughts are that bugfix releases should be committed to 'master' the
> same as the stable/rc releases are. Then the tag created from that commit.

How do you want to commit bugfix release (e.g. v2.29.2) to the
'master' if the master and 'stable/' branches contain a different
code? 

The current workflow:

 1) development (branch: <master>)

 2) master release (tags: v2.29-rc1, v2.29-rc2, v2.29, branch: <master>)

 3) development (work on v2.30, branch: <master>)

 4) fork -- create a new branch <stable/v2.29> based on tag v2.29

     4a) new patches or cherry-pick patches from <master> (branch: <stable/v2.29>)

     4b) stable release (tag: v2.29.1, branch: <stable/v2.29>)

     4c) another patches, another release (tag: v2.29.2, branch: <stable/v2.29>)

 5) master release v2.30 (branch: <master>)
    ...


where 3) and 4) happen in the same time.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
