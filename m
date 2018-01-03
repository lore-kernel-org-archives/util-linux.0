Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbeACKLR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 3 Jan 2018 05:11:17 -0500
Date: Wed, 3 Jan 2018 11:11:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: Regression test failure
Message-ID: <20180103101113.akwkrmlxon2cyxmz@ws.net.home>
References: <5A39782D.1030608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5A39782D.1030608@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 19, 2017 at 02:35:57PM -0600, Bruce Dubbs wrote:
> In version 2.31.1, I had one failure:
> 
> fincore: count file contents in core   ... FAILED (fincore/count)
> 
>   1 tests of 200 FAILED
> 
> $ cat ./tests/diff/fincore/count
> --- /sources/util-linux-2.31.1/tests/expected/fincore/count.4096 2017-09-18
> 09:48:03.676890826 +0000
> +++ /sources/util-linux-2.31.1/tests/output/fincore/count       2017-12-19
> 20:18:24.410460239 +0000
> @@ -13,7 +13,7 @@
>  return value: 0
>      0  8192 i_TWO_PAGES_directio_
>  return value: 0
> -    1  8192 i_TWO_PAGES_mixed_directio_incore_
> +    2  8192 i_TWO_PAGES_mixed_directio_incore_
>  return value: 0
>      1  8192 i_TWO_PAGES_mixed_incore_directio_
>  return value: 0
> @@ -42,7 +42,7 @@
>      0      4096 i_JUST_PAGESIZE_directio_
>      2      8192 i_TWO_PAGES_incore_
>      0      8192 i_TWO_PAGES_directio_
> -    1      8192 i_TWO_PAGES_mixed_directio_incore_
> +    2      8192 i_TWO_PAGES_mixed_directio_incore_
>      1      8192 i_TWO_PAGES_mixed_incore_directio_
>      2 134213632 i_WINDOW_SIZE_incore-sparse-incore_
>      0 134213632 i_WINDOW_SIZE_directio-sparse-directio_

Frankly, this test seems pretty unstable. I'll probably mark it as
KNOWN_FAIL.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
