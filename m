Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6431 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbaHLMha (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Aug 2014 08:37:30 -0400
Date: Tue, 12 Aug 2014 14:37:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] docs: improve the description of --size in the man page
 of zramctl
Message-ID: <20140812123725.GM17719@x2.net.home>
References: <1407788619-4298-1-git-send-email-bensberg@justemail.net>
 <1407789244.2112503.151580837.566CF6FE@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407789244.2112503.151580837.566CF6FE@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 11, 2014 at 10:34:04PM +0200, Benno Schulenberg wrote:
> 
> On Mon, Aug 11, 2014, at 22:23, Benno Schulenberg wrote:
> > The zram devices size is page size aligned.  When
> > -requested
> > -.I size
> > -does match with page size the device be large enough to hold the reqested
> > -.I size
> > -plus length to next page boundary.
> 
> The above does not parse for me.  I am not in a position to test
> zram devices, so to be sure that my replacement text is correct,

  # modprobe zram 

  # ./zramctl --find --size $((4096 * 1000 + 100 ))
  /dev/zram0

  # echo $(( 4096 * 1000 + 100))
  4096100
  
  # ./zramctl --bytes -n -o DISKSIZE
  4100096


> the following question: when one passes with --size a number that
> is not a multiple of the memory-page size, does a subsequent call
> of 'zramctl --raw' then print the aligned (rounded-up) number, or
> does it still print the size that was specified although in fact
> the aligned, bigger number is being used?

 The kernel uses the aligned $size and nowhere is stored the original
 size, so zramctl returns the aligned (rounded-up) number.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
