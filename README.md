dummyデータを簡単に作る仕組みを見て感動したがテスト毎に必要に応じて ->delete してたので、スコープを抜けると自分で自分を削除するようにできないかなと思って試してみた

https://github.com/mix3/dummy-auto-delete-example/blob/master/lib/MyApp/Test/Dummy.pm#L44
```
    {
        no strict qw/refs/;
        *{$result_class."::DESTROY"} = sub {
            my $self = shift;
            if ($self->{_auto_delete}) {
                $self->delete;
            }
        };
    }
```
こんな感じで無理やりDESTROYを生やして

https://github.com/mix3/dummy-auto-delete-example/blob/master/t/Util.pm#L53
```
sub dummy_auto_del {
    my $dummy = MyApp::Test::Dummy->create(@_);
    $dummy->{_auto_delete} = 1;
    $dummy;
}
```
こんな感じで自動で消したい場合はフラグを持たせれば出来なくは無いようだ
