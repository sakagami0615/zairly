export default function Home() {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center p-8">
      <main className="flex flex-col gap-8 items-center">
        <h1 className="text-4xl font-bold">Zairly</h1>
        <p className="text-xl text-center">
          AI在庫管理アプリ
        </p>
        <div className="text-center text-sm text-gray-500">
          <p>チャット形式で簡単に在庫を管理できます</p>
          <p className="mt-2">※ 現在開発中です</p>
        </div>
      </main>
    </div>
  );
}
